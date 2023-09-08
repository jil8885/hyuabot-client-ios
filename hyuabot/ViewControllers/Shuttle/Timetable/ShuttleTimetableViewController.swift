import UIKit
import QueryAPI
import RxSwift

class ShuttleTimetableViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)
        )
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        
        let weekdaysShuttleListViewController = ShuttleTimetableListViewController(date: .weekdays)
        let weekendsShuttleListViewController = ShuttleTimetableListViewController(date: .weekends)

        viewPager.pagedView.pages = [
            weekdaysShuttleListViewController.view,
            weekendsShuttleListViewController.view,
        ]
        
        viewPager.tabbedView.tabs = [
            AppTabItem(title: String.localizedShuttleItem(resourceID: "shuttle.days.weekdays")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "shuttle.days.weekends")),
        ]
        
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(viewPager)
        appDelegate.shuttleTimetableQueryParams.subscribe(onNext: {(params) in
            if (params != nil) {
                guard let stopID = params?.stopID else { return }
                guard let destination = params?.destination else { return }
                self.appDelegate.queryShuttleTimetablePage(stopID: stopID, destination: destination)
            }
        }).disposed(by: self.disposeBag)
        
        NSLayoutConstraint.activate([
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
