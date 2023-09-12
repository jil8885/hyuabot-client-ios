import UIKit
import RxSwift
import QueryAPI

class SubwayTimetableViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    private var stationID: String = ""
    private var heading: SubwayHeading? = nil
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)
        )
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        
        let weekdaysSubwayListViewController = SubwayTimetableListViewController(stationID: self.stationID, heading: self.heading!, weekdays: .weekdays)
        let weekendsSubwayListViewController = SubwayTimetableListViewController(stationID: self.stationID, heading: self.heading!, weekdays: .weekends)


        viewPager.pagedView.pages = [
            weekdaysSubwayListViewController.view,
            weekendsSubwayListViewController.view,
        ]
        
        viewPager.tabbedView.tabs = [
            AppTabItem(title: String.localizedSubwayItem(resourceID: "subway.days.weekdays")),
            AppTabItem(title: String.localizedSubwayItem(resourceID: "subway.days.weekends")),
        ]
        
        return viewPager
    }()
    
    init(stationID: String, heading: SubwayHeading) {
        super.init(nibName: nil, bundle: nil)
        self.stationID = stationID
        self.heading = heading
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(viewPager)
        NSLayoutConstraint.activate([
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        self.appDelegate.querySubwayTimetablePage(stationID: self.stationID, heading: self.heading!)
    }
}
