import UIKit

class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SettingTableViewCell.identifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.settingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(settingLabel)
        self.contentView.addSubview(dataLabel)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(rightArrowImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            iconImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            iconImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            settingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            settingLabel.leftAnchor.constraint(equalTo: self.iconImageView.rightAnchor, constant: 20),
            settingLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            settingLabel.widthAnchor.constraint(equalToConstant: 200),
            dataLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            dataLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            dataLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            rightArrowImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            rightArrowImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            rightArrowImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
        ])
    }
    
    func setUpCell(label: String.LocalizationValue) {
        settingLabel.text = String.localizedSettingsItem(resourceID: label)
        dataLabel.text = ""
        rightArrowImageView.isHidden = false
        switch label {
            case "app.version":
                iconImageView.image = UIImage(systemName: "info.circle")
                rightArrowImageView.isHidden = true
                guard let dictionary = Bundle.main.infoDictionary,
                    let version = dictionary["CFBundleShortVersionString"] as? String else { return }
                dataLabel.text = version
                self.selectionStyle = .none
            case "app.theme":
                iconImageView.image = UIImage(systemName: "paintbrush")
            case "app.developer":
                iconImageView.image = UIImage(systemName: "person")
            case "app.contact":
                iconImageView.image = UIImage(systemName: "envelope")
            default:
                break
        }
    }
}
