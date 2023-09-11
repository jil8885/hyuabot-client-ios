import UIKit
import QueryAPI
import RxSwift

class SubwayRealtimeViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)
        )
        
        let line4ListViewController = SubwayRealtimeListViewController(subwayType: .skyblue)
        let lineSuinListViewController = SubwayRealtimeListViewController(subwayType: .yellow)
        let transferListViewController = SubwayRealtimeListViewController(subwayType: .transfer)
        
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        viewPager.pagedView.pages = [
            line4ListViewController.view,
            lineSuinListViewController.view,
            transferListViewController.view,
        ]
        
        viewPager.tabbedView.tabs = [
            AppTabItem(title: String.localizedSubwayItem(resourceID: "skyblue")),
            AppTabItem(title: String.localizedSubwayItem(resourceID: "yellow")),
            AppTabItem(title: String.localizedSubwayItem(resourceID: "transfer")),
        ]
        
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(viewPager)
        appDelegate.querySubwayRealtimePage()
        
        NSLayoutConstraint.activate([
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // Polling Query every 1 minute
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Observable<Int>.interval(.seconds(60), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.appDelegate.querySubwayRealtimePage()
            })
            .disposed(by: disposeBag)
    }
}
