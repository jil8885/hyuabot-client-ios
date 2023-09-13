import UIKit
import RxSwift

class BusNavigationController: UINavigationController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        subscribeTimetableQueryParams()
    }
    
    // Configure navigation bar
    func configureNavigationBar(){
        navigationBar.backgroundColor = UIColor(named: "HanyangPrimary")
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.godo(size: 18, weight: .bold)]
    }
    
    // Listen timetable query params
    func subscribeTimetableQueryParams(){
        appDelegate.busTimetableQueryParams
            .subscribe(onNext: {(params) in
                if (params != nil) {
                    let busTimetableVC = BusTimetableViewController()
                    self.pushViewController(busTimetableVC, animated: true)
                    
                    var sectionList: [String] = []
                    guard let busType = params?.busType else { return }
                    switch busType {
                    case .local:
                        sectionList = ["bus.route.10-1.sangnoksu", "bus.route.10-1.purgio"]
                    case .seoul:
                        sectionList = ["bus.route.3102", "bus.route.3100", "bus.route.3101"]
                    case .suwon:
                        sectionList = ["bus.route.707-1", "bus.route.suwon"]
                    }
                    busTimetableVC.navigationItem.title = String.localizedBusItem(resourceID: String.LocalizationValue(sectionList[params!.sectionIndex]))
                    
                }
            })
            .disposed(by: disposeBag)
    }
}
