import UIKit
import RxSwift
import QueryAPI

class ShuttleRealtimeListItemView: UITableViewCell {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    static let identifier = "ShuttleRealtimeListItemView"
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
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
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(remainingTimeLabel)
        self.appDelegate.showShuttleRemainingTime
            .subscribe(onNext: {(item) in
                if (item) {
                    self.timeLabel.isHidden = true
                    self.remainingTimeLabel.isHidden = false
                } else {
                    self.timeLabel.isHidden = false
                    self.remainingTimeLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            typeLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            typeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            remainingTimeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            remainingTimeLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            remainingTimeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(item: ShuttleArrivalItem) {
        let timeValue = item.timetable.time.split(separator: ":")
        let hour = String(timeValue[0])
        let minute = String(timeValue[1])
        timeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_time_format_\(hour)_\(minute)")
        remainingTimeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_remaining_time_format_\(Int(item.timetable.remainingTime / 60))")

        if item.tag == "C" {
            typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_C")
            typeLabel.textColor = .darkText
        } else if (item.tag == "DH" || item.tag == "DY") {
            typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_DH")
            typeLabel.textColor = .red
        } else {
            typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_DJ")
            typeLabel.textColor = .blue
        }
    }
}
