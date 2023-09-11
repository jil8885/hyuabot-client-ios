import UIKit

final class BusRealtimeFooterView: UITableViewHeaderFooterView {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var busType: BusType?
    private var sectionIndex: Int?
    
    
    static let identifier = "BusRealtimeFooterView"
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
    
    func setUpFooterView(busType: BusType, sectionIndex: Int){
        showEntireScheduleButton.titleLabel?.text = String.localizedBusItem(resourceID: "show_entire_schedule")
        showEntireScheduleButton.translatesAutoresizingMaskIntoConstraints = false
        showEntireScheduleButton.addTarget(self, action: #selector(clickShowEntireScheduleButton), for: .touchUpInside)
        self.busType = busType
        self.sectionIndex = sectionIndex
        self.contentView.addSubview(showEntireScheduleButton)
        self.contentView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            showEntireScheduleButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            showEntireScheduleButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            showEntireScheduleButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            showEntireScheduleButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        if busType == .suwon && sectionIndex == 1 {
            showEntireScheduleButton.isEnabled = false
        } else {
            showEntireScheduleButton.isEnabled = true
        }
    }
    
    @objc func clickShowEntireScheduleButton(sender: UIButton){
        appDelegate.busTimetableQueryParams.onNext(BusTimetableQueryParams(busType: self.busType!, sectionIndex: self.sectionIndex!))
    }
}
