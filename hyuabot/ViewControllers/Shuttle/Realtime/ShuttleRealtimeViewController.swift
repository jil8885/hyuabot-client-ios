import UIKit
import QueryAPI

class ShuttleRealtimeViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fixed(width: 150, height: 60, spacing: 0)
        )
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        
        let dormitoryShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .dormitoryOut
        )
        let shuttlecockShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .shuttlecockOut
        )
        let stationShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .station
        )
        let terminalShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .terminal
        )
        let jungangStationShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .jungangStation
        )
        let shuttlecockInShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .shuttlecockIn
        )
        
        
        viewPager.pagedView.pages = [
            dormitoryShuttleListViewController.view,
            shuttlecockShuttleListViewController.view,
            stationShuttleListViewController.view,
            terminalShuttleListViewController.view,
            jungangStationShuttleListViewController.view,
            shuttlecockInShuttleListViewController.view,
        ]
        
        viewPager.tabbedView.tabs = [
            AppTabItem(title: String.localizedShuttleItem(resourceID: "dormitory_o")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "shuttlecock_o")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "station")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "terminal")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "jungang_station")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "shuttlecock_i")),
        ]
        
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String.localizedNavTitle(resourceID: "shuttle.realtime")
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(viewPager)
        appDelegate.queryShuttleRealtimePage()
        
        NSLayoutConstraint.activate([
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
