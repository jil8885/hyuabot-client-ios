import UIKit
import RxSwift
import QueryAPI

class BusRealtimeListItemView: UITableViewCell {
    static let identifier = "BusRealtimeListItemView"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    private let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkText
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
    
    func setUpCell(item: BusArrivalItem){
        if item.realtime == nil && item.timetable == nil {
            timeLabel.text = ""
            remainingTimeLabel.text = ""
            return
        } else if item.realtime != nil {
            remainingTimeLabel.isHidden = false
            timeLabel.isHidden = true
            guard let realtime = item.realtime else { return }
            let remainingTime = realtime.realtime!.remainingTime
            let remainingStop = realtime.realtime!.remainingStop
            let remainingSeat = realtime.realtime!.remainingSeat
            if remainingSeat < 0 {
                remainingTimeLabel.text = String.localizedBusItem(resourceID: "bus.arrival.realtime.no.seat.\(String(remainingTime)).\(String(remainingStop))")
            } else {
                remainingTimeLabel.text = String.localizedBusItem(resourceID: "bus.arrival.realtime.seat.\(String(remainingTime)).\(String(remainingStop)).\(String(remainingSeat))")
            }
            
            if realtime.routeName == "110" || realtime.routeName == "707" || realtime.routeName == "909" {
                typeLabel.text = realtime.routeName
                typeLabel.isHidden = false
            } else {
                typeLabel.isHidden = true
            }
        } else {
            guard let timetable = item.timetable else { return }
            let timeValue = timetable.time.split(separator: ":")
            let hour = String(timeValue[0])
            let minute = String(timeValue[1])
            typeLabel.text = String.localizedBusItem(resourceID: "bus.arrival.timetable")
            remainingTimeLabel.isHidden = true
            timeLabel.isHidden = false
            timeLabel.text = String.localizedBusItem(resourceID: "bus.arrival.timetable.\(hour).\(minute)")
        }
    }
}
