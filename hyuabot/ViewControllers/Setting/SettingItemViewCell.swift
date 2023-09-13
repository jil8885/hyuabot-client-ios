import UIKit

class SettingItemViewCell: UITableViewCell {
    static let identifier = "SettingItemViewCell"
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .regular)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SettingTableViewCell.identifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.dataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dataLabel)
        NSLayoutConstraint.activate([
            dataLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            dataLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            dataLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            dataLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
        ])
    }
    
    func setUpCell(label: String.LocalizationValue) {
        dataLabel.text = String.localizedSettingsItem(resourceID: label)
    }
}
