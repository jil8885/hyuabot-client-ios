import UIKit
import QueryAPI

class SubwayTimetableListItemView: UITableViewCell {
    static let identifier = "SubwayTimetableListItemView"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .bold)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(item: SubwayTimetableUpQuery.Data.Subway.Timetable.Up) {
        let timeValue = item.time.split(separator: ":")
        let hour = String(timeValue[0])
        let minute = String(timeValue[1])
        timeLabel.text = String.localizedSubwayItem(resourceID: "subway.timetable.item.\(hour).\(minute)")
        typeLabel.text = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(item.destinationID)")))
    }
    
    func setUpCell(item: SubwayTimetableDownQuery.Data.Subway.Timetable.Down) {
        let timeValue = item.time.split(separator: ":")
        let hour = String(timeValue[0])
        let minute = String(timeValue[1])
        timeLabel.text = String.localizedSubwayItem(resourceID: "subway.timetable.item.\(hour).\(minute)")
        typeLabel.text = String.localizedSubwayItem(resourceID: String.LocalizationValue(String("subway.arrival.destination.\(item.destinationID)")))
    }
    
    func setupView() {
        addSubview(typeLabel)
        addSubview(timeLabel)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            typeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            typeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}
