import UIKit
import QueryAPI
import RxSwift
import Then

class CafeteriaViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    
    lazy var viewPager: ViewPager = {
        let breakfastView = CafeteriaListViewController(mealType: .breakfast)
        let lunchView = CafeteriaListViewController(mealType: .lunch)
        let dinnerView = CafeteriaListViewController(mealType: .dinner)
        
        let viewPager = ViewPager(tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.pagedView.pages = [
                breakfastView.view,
                lunchView.view,
                dinnerView.view,
            ]
            $0.tabbedView.tabs = [
                AppTabItem(title: String.localizedCafeteriaItem(resourceID: "cafeteria.type.breakfast")),
                AppTabItem(title: String.localizedCafeteriaItem(resourceID: "cafeteria.type.lunch")),
                AppTabItem(title: String.localizedCafeteriaItem(resourceID: "cafeteria.type.dinner")),
            ]
        }
        return viewPager
    }()
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "HanyangSecondary")
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "calendar")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        button.configuration = config
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 40)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        appDelegate.queryCafeteriaPage()
        appDelegate.cafeteriaQueryParams.subscribe(onNext: {(params) in
            if (params != nil) {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd"
                self.appDelegate.queryCafeteriaPage(dateQuery: dateFormater.string(from: params!))
            }
        }).disposed(by: disposeBag)
    }
    
    func setupView(){
        self.view.do {
            $0.addSubview(viewPager)
            $0.addSubview(calendarButton)
            $0.backgroundColor = .systemBackground
        }
        NSLayoutConstraint.activate([
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            calendarButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            calendarButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    @objc func calendarButtonClicked(){
        let popUpViewController = CafeteriaParamViewController()
        present(popUpViewController, animated: false, completion: nil)
    }
}
