import UIKit
import RxSwift
import QueryAPI

class BusTimetableViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)
        )
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        
        let weekdaysShuttleListViewController = BusTimetableListViewController(date: .weekdays)
        let saturdaysShuttleListViewController = BusTimetableListViewController(date: .saturdays)
        let sundaysShuttleListViewController = BusTimetableListViewController(date: .sundays)


        viewPager.pagedView.pages = [
            weekdaysShuttleListViewController.view,
            saturdaysShuttleListViewController.view,
            sundaysShuttleListViewController.view,
        ]
        
        viewPager.tabbedView.tabs = [
            AppTabItem(title: String.localizedBusItem(resourceID: "bus.days.weekdays")),
            AppTabItem(title: String.localizedBusItem(resourceID: "bus.days.saturdays")),
            AppTabItem(title: String.localizedBusItem(resourceID: "bus.days.sundays")),
        ]
        
        return viewPager
    }()
    
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
        appDelegate.busTimetableQueryParams.subscribe(onNext: {(params) in
            if (params != nil) {
                guard let busType = params?.busType else { return }
                guard let sectionIndex = params?.sectionIndex else { return }
                var query: [BusRouteStopQuery] = []
                
                if busType == .local {
                    if sectionIndex == 0 {
                        query.append(BusRouteStopQuery(stop: 216000138, route: 216000068))
                    } else if sectionIndex == 1 {
                        query.append(BusRouteStopQuery(stop: 216000379, route: 216000068))
                    }
                }
                else if busType == .seoul {
                    if sectionIndex == 0 {
                        query.append(BusRouteStopQuery(stop: 216000379, route: 216000061))
                    } else if sectionIndex == 1 {
                        query.append(BusRouteStopQuery(stop: 216000719, route: 216000026))
                        query.append(BusRouteStopQuery(stop: 216000719, route: 216000096))
                    } else if sectionIndex == 2 {
                        query.append(BusRouteStopQuery(stop: 216000719, route: 216000043))
                    }
                
                }
                else if busType == .suwon {
                    if sectionIndex == 0 {
                        query.append(BusRouteStopQuery(stop: 216000719, route: 216000070))
                    }
                }
                self.appDelegate.queryBusTimetablePage(query: query)
            }
        }).disposed(by: self.disposeBag)
    }
}
