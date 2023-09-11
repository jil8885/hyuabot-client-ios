import UIKit

final class ShuttleStopTableCell: UITableViewCell {
    static let identifier = "ShuttleStopTableCell"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(timeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            typeLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            typeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(type: String, first: String?, last: String?) {        
        self.typeLabel.text = String.localizedShuttleItem(resourceID: String.LocalizationValue(type))
        
        var firstHour = "--"
        var firstMinute = "--"
        var lastHour = "--"
        var lastMinute = "--"
        
        if first != nil {
            let firstSplit = first!.split(separator: ":")
            firstHour = String(firstSplit[0])
            firstMinute = String(firstSplit[1])
        }
        if last != nil {
            let lastSplit = last!.split(separator: ":")
            lastHour = String(lastSplit[0])
            lastMinute = String(lastSplit[1])
        }
        self.timeLabel.text = String.localizedShuttleItem(resourceID: "shuttle.first.last.\(firstHour).\(firstMinute).\(lastHour).\(lastMinute)")
    }
}
