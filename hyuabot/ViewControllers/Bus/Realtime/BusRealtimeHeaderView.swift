import UIKit

final class BusRealtimeHeaderView: UITableViewHeaderFooterView {
    static let identifier = "BusRealtimeHeaderView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeaderView(label: String) {
        titleLabel.text = label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        self.contentView.backgroundColor = UIColor(named: "HanyangPrimary")
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
