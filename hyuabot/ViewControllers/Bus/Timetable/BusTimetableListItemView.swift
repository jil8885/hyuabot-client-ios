import UIKit
import QueryAPI

class BusTimetableListItemView: UITableViewCell {
    static let identifier = "BusTimetableListItemView"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
    
    func setUpCell(item: BusTimetableArrivalItem) {
        let timeValue = item.time.split(separator: ":")
        let hour = String(timeValue[0])
        let minute = String(timeValue[1])
        timeLabel.text = String.localizedBusItem(resourceID: "bus.time.format.\(hour).\(minute)")
    }
    
    func setupView() {
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}
