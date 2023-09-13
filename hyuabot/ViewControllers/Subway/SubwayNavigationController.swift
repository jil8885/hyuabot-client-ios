import UIKit
import RxSwift

class SubwayNavigationController: UINavigationController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        subscribeTimetableQueryParams()
    }

    // Listen timetable query params
    func subscribeTimetableQueryParams(){
        appDelegate.subwayTimetableQueryParams
            .subscribe(onNext: {(params) in
                if (params != nil) {
                    guard let subwayType = params?.subwayType else { return }
                    guard let heading = params?.heading else { return }
                    let subwayTimetableVC = SubwayTimetableViewController(
                        stationID: subwayType == .skyblue ? "K449" : "K251",
                        heading: heading
                    )
                    self.pushViewController(subwayTimetableVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
