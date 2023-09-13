import UIKit
import QueryAPI
import RxSwift

class ShuttleTimetableViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    var stopID: String?
    var destination: String?
    var period: String?
    
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
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "HanyangSecondary")
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "line.3.horizontal.decrease")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        button.configuration = config
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .godo(size: 40)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(viewPager)
        self.view.addSubview(filterButton)
        appDelegate.shuttleTimetableQueryParams.subscribe(onNext: {(params) in
            if (params != nil) {
                guard let stopID = params?.stopID else { return }
                guard let destination = params?.destination else { return }
                self.appDelegate.queryShuttleTimetablePage(stopID: stopID, destination: destination)
                self.stopID = stopID
                self.destination = destination
            }
        }).disposed(by: self.disposeBag)
        
        NSLayoutConstraint.activate([
            filterButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            filterButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func filterButtonClicked(_ sender: UIButton) {
        guard let stopID = self.stopID else { return }
        guard let destination = self.destination else { return }
        
        let popUpViewController = ShuttleTimetableParamViewController(stopID: stopID, destination: destination)
        present(popUpViewController, animated: false, completion: nil)
    }
}
