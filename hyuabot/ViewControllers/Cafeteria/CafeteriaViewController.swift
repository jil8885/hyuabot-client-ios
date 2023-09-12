import UIKit
import QueryAPI
import RxSwift
import Then

class CafeteriaViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    lazy var viewPager: ViewPager = {
//        let localVC = BusRealtimeListViewController(busType: .local)
//        let seoulVC = BusRealtimeListViewController(busType: .seoul)
//        let suwonVC = BusRealtimeListViewController(busType: .suwon)
        
        let viewPager = ViewPager(tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.pagedView.pages = [
                UIView(),
                UIView(),
                UIView(),
            ]
            $0.tabbedView.tabs = [
                AppTabItem(title: String.localizedCafeteriaItem(resourceID: "cafeteria.type.breakfast")),
                AppTabItem(title: String.localizedCafeteriaItem(resourceID: "cafeteria.type.lunch")),
                AppTabItem(title: String.localizedCafeteriaItem(resourceID: "cafeteria.type.dinner")),
            ]
        }
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        appDelegate.queryCafeteriaPage()
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
}
