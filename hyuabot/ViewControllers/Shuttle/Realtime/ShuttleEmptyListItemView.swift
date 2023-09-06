import UIKit
import QueryAPI

class ShuttleEmptyListItemView: UITableViewCell {
    static let identifier = "ShuttleEmptyListItemView"
    private let noInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkText
        label.textAlignment = .center
        label.text = String.localizedShuttleItem(resourceID: "shuttle_realtime_empty")
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(noInfoLabel)
        self.selectionStyle = .none
        noInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noInfoLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            noInfoLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            noInfoLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            noInfoLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
