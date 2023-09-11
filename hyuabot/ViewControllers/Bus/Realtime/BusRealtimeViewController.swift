import UIKit
import QueryAPI
import RxSwift
import Then

class BusRealtimeViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    lazy var viewPager: ViewPager = {
        let localVC = BusRealtimeListViewController(busType: .local)
        let seoulVC = BusRealtimeListViewController(busType: .seoul)
        let suwonVC = BusRealtimeListViewController(busType: .suwon)
        
        let viewPager = ViewPager(tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.pagedView.pages = [
                localVC.view,
                seoulVC.view,
                suwonVC.view,
            ]
            $0.tabbedView.tabs = [
                AppTabItem(title: String.localizedBusItem(resourceID: "bus.type.local")),
                AppTabItem(title: String.localizedBusItem(resourceID: "bus.type.seoul")),
                AppTabItem(title: String.localizedBusItem(resourceID: "bus.type.suwon")),
            ]
        }
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        appDelegate.queryBusRealtimePage()
    }
    
    func setupView(){
        self.view.do {
            $0.addSubview(viewPager)
            $0.backgroundColor = .systemBackground
        }
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
                self?.appDelegate.queryBusRealtimePage()
            })
            .disposed(by: disposeBag)
    }
}
