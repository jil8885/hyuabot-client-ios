import UIKit

final class ShuttleRealtimeFooterView: UITableViewHeaderFooterView {
    static let identifier = "ShuttleRealtimeFooterView"
    private let showEntireScheduleButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var title = AttributedString.init(String.localizedShuttleItem(resourceID: "show_entire_schedule"))
        title.font = .systemFont(ofSize: 16)
        config.attributedTitle = title
        
        return UIButton(configuration: config, primaryAction: nil)
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpFooterView(stopID: String, destination: String){
        showEntireScheduleButton.titleLabel?.text = String.localizedShuttleItem(resourceID: "show_entire_schedule")
        showEntireScheduleButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(showEntireScheduleButton)
        self.contentView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            showEntireScheduleButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            showEntireScheduleButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            showEntireScheduleButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            showEntireScheduleButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
