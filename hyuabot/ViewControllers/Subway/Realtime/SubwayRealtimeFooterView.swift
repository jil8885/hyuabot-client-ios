import UIKit

final class SubwayRealtimeFooterView: UITableViewHeaderFooterView {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var subwayType: SubwayType?
    private var heading: SubwayHeading?
    
    static let identifier = "SubwayRealtimeFooterView"
    private let showEntireScheduleButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var title = AttributedString.init(String.localizedSubwayItem(resourceID: "show.entire.schedule"))
        title.font = .godo(size: 16)
        config.attributedTitle = title
        
        return UIButton(configuration: config, primaryAction: nil)
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpFooterView(subwayType: SubwayType, heading: SubwayHeading){
        showEntireScheduleButton.titleLabel?.text = String.localizedSubwayItem(resourceID: "show.entire.schedule")
        showEntireScheduleButton.translatesAutoresizingMaskIntoConstraints = false
        showEntireScheduleButton.addTarget(self, action: #selector(clickShowEntireScheduleButton), for: .touchUpInside)
        self.subwayType = subwayType
        self.heading = heading
        self.contentView.addSubview(showEntireScheduleButton)
        self.contentView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            showEntireScheduleButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            showEntireScheduleButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            showEntireScheduleButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            showEntireScheduleButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        if subwayType == .transfer {
            showEntireScheduleButton.isEnabled = false
        } else {
            showEntireScheduleButton.isEnabled = true
        }
    }
    
    @objc func clickShowEntireScheduleButton(sender: UIButton){
        appDelegate.subwayTimetableQueryParams.onNext(SubwayTimetableQueryParams(subwayType: self.subwayType!, heading: self.heading!))
    }
}
