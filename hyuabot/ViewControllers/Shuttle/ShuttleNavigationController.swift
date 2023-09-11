import UIKit
import RxSwift

class ShuttleNavigationController: UINavigationController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        subscribeTimetableQueryParams()
        subscribeStopQueryParams()
    }
    
    // Configure navigation bar
    func configureNavigationBar(){
        navigationBar.backgroundColor = UIColor(named: "HanyangPrimary")
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    // Listen timetable query params
    func subscribeTimetableQueryParams(){
        appDelegate.shuttleTimetableQueryParams
            .subscribe(onNext: {(params) in
                if (params != nil) {
                    let shuttleTimetableVC = ShuttleTimetableViewController()
                    guard let stopID = params?.stopID else { return }
                    guard let destinationID = params?.destination else { return }
                    let destinationKey = "\(destinationID)_shorten"
                    let stop = String.localizedShuttleItem(resourceID: String.LocalizationValue(stopID))
                    let destination = String.localizedShuttleItem(resourceID: String.LocalizationValue(destinationKey))
                    shuttleTimetableVC.navigationItem.title = String.localizedShuttleItem(resourceID: "shuttle.timetable.\(stop).\(destination)")
                    self.pushViewController(shuttleTimetableVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // Listen stop query params
    func subscribeStopQueryParams(){
        appDelegate.shuttleStopQueryParams
            .subscribe(onNext: {(params) in
                if (params != nil) {
                    let shuttleStopVC = ShuttleStopViewController(shuttleStop: params)
                    let shuttleStopNC = UINavigationController(rootViewController: shuttleStopVC)
                    shuttleStopNC.modalPresentationStyle = .automatic
                    self.present(shuttleStopNC, animated: true, completion: nil)
                }
            }).disposed(by: disposeBag)
    }
}
