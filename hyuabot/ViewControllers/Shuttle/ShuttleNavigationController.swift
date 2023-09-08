import UIKit
import RxSwift

class ShuttleNavigationController: UINavigationController {
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
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    // Listen timetable query params
    func subscribeTimetableQueryParams(){
        appDelegate.shuttleTimetableQueryParams
            .subscribe(onNext: {(item) in
                if (item != nil) {
                    print(item)
                }
            })
            .disposed(by: disposeBag)
    }
}
