import UIKit
import RxSwift
import QueryAPI

class SubwayRealtimeListItemView: UITableViewCell {
    static let identifier = "SubwayRealtimeListItemView"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16)
        label.textAlignment = .center
        return label
    }()
    private let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(typeLabel)
        addSubview(timeLabel)
        addSubview(remainingTimeLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            typeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            typeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            remainingTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            remainingTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            remainingTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    func setUpCell(item: SubwayArrivalItem){
        if item.upRealtime != nil {
            remainingTimeLabel.isHidden = false
            timeLabel.isHidden = true
            guard let realtime = item.upRealtime else { return }
            let destination = realtime.destinationID
            let remainingTime = realtime.remainingTime
            let remainingStop = realtime.remainingStation
            
            typeLabel.text = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(destination)")))
            remainingTimeLabel.text = String.localizedSubwayItem(resourceID: "subway.arrival.information.\(String(remainingTime)).\(String(remainingStop))")
        } else if item.downRealtime != nil {
            remainingTimeLabel.isHidden = false
            timeLabel.isHidden = true
            guard let realtime = item.downRealtime else { return }
            let destination = realtime.destinationID
            let remainingTime = realtime.remainingTime
            let remainingStop = realtime.remainingStation
            
            typeLabel.text = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(destination)")))
            remainingTimeLabel.text = String.localizedSubwayItem(resourceID: "subway.arrival.information.\(String(remainingTime)).\(String(remainingStop))")
        } else if item.timetable != nil {
            guard let timetable = item.timetable else { return }
            let timeValue = timetable.time.split(separator: ":")
            let hour = String(timeValue[0])
            let minute = String(timeValue[1])
            let destination = timetable.destinationID
            typeLabel.isHidden = false
            typeLabel.text = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(destination)")))
            remainingTimeLabel.isHidden = true
            timeLabel.isHidden = false
            timeLabel.text = String.localizedSubwayItem(resourceID: "subway.arrival.timetable.\(hour).\(minute)")
        } else if item.transferItem != nil {
            guard let transferItem = item.transferItem else { return }
            remainingTimeLabel.isHidden = true
            timeLabel.isHidden = false
            typeLabel.isHidden = true
            if transferItem.upFrom != nil {
                if transferItem.upTo != nil {
                    let realtimeDestination = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(transferItem.upFrom!.destinationID)")))
                    let timetableDestination = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(transferItem.upTo!.destinationID)")))
                    let timeValue = transferItem.upTo!.time.split(separator: ":")
                    let hour = String(timeValue[0])
                    let minute = String(timeValue[1])
                    let location = transferItem.upFrom!.location.replacingOccurrences(of: "인더스파크", with: "공단")
                    let timeString = String.localizedSubwayItem(resourceID: "subway.timetable.item.\(hour).\(minute)")
                    timeLabel.text = String.localizedSubwayItem(resourceID: "transfer.realtime.\(realtimeDestination).\(location).\(timetableDestination).\(timeString)")
                } else {
                    let destination = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(transferItem.upFrom!.destinationID)")))
                    typeLabel.text = String.localizedSubwayItem(resourceID: "suin.direct")
                    timeLabel.text = String.localizedSubwayItem(resourceID: "transfer.realtime.\(destination).\(String(transferItem.upFrom!.location))")
                }
            } else if transferItem.downFrom != nil {
                if transferItem.downTo != nil {
                    typeLabel.isHidden = true
                    let realtimeDestination = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(transferItem.downFrom!.destinationID)")))
                    let timetableDestination = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(transferItem.downTo!.destinationID)")))
                    let timeValue = transferItem.downTo!.time.split(separator: ":")
                    let hour = String(timeValue[0])
                    let minute = String(timeValue[1])
                    let timeString = String.localizedSubwayItem(resourceID: "subway.timetable.item.\(hour).\(minute)")
                    timeLabel.text = String.localizedSubwayItem(resourceID: "transfer.realtime.\(realtimeDestination).\(String(transferItem.downFrom!.location)).\(timetableDestination).\(timeString)")
                } else {
                    let destination = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(transferItem.downFrom!.destinationID)")))
                    typeLabel.text = String.localizedSubwayItem(resourceID: "suin.direct")
                    timeLabel.text = String.localizedSubwayItem(resourceID: "transfer.realtime.\(destination).\(transferItem.downFrom!.location)")
                }
            }
        }
    }
}
