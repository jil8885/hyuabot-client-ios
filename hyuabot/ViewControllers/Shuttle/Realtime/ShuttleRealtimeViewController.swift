import UIKit
import QueryAPI
import RxSwift
import CoreLocation
import AppTrackingTransparency

class ShuttleRealtimeViewController: UIViewController, CLLocationManagerDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    let stopLocation = [
        CLLocation(latitude: 37.29339607529377, longitude: 126.83630604103446),
        CLLocation(latitude:37.29875417910844, longitude: 126.83784054072336),
        CLLocation(latitude:37.3096539, longitude: 126.8520997),
        CLLocation(latitude:37.31945164682341, longitude: 126.8455453372041),
        CLLocation(latitude:37.3147818, longitude: 126.8397399),
        CLLocation(latitude:37.29869328231496, longitude: 126.8377767466817),
    ]
    
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fixed(width: 150, height: 60, spacing: 0)
        )
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        
        let dormitoryShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .dormitoryOut
        )
        let shuttlecockShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .shuttlecockOut
        )
        let stationShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .station
        )
        let terminalShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .terminal
        )
        let jungangStationShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .jungangStation
        )
        let shuttlecockInShuttleListViewController = ShuttleRealtimeListViewController(
            stopID: .shuttlecockIn
        )
        
        
        viewPager.pagedView.pages = [
            dormitoryShuttleListViewController.view,
            shuttlecockShuttleListViewController.view,
            stationShuttleListViewController.view,
            terminalShuttleListViewController.view,
            jungangStationShuttleListViewController.view,
            shuttlecockInShuttleListViewController.view,
        ]
        
        viewPager.tabbedView.tabs = [
            AppTabItem(title: String.localizedShuttleItem(resourceID: "dormitory_o")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "shuttlecock_o")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "station")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "terminal")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "jungang_station")),
            AppTabItem(title: String.localizedShuttleItem(resourceID: "shuttlecock_i")),
        ]
        
        return viewPager
    }()
    
    private lazy var toggleButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(named: "HanyangSecondary")
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "clock")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        button.configuration = config
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(toggleButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .godo(size: 40)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.startUpdatingLocation()
            } else {
                self.showToast(message: String.localizedItem(resourceID: "location_disabled"))
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.locationManager.requestWhenInUseAuthorization()
            self.requestTrackingAuthorization()
        }
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(viewPager)
        self.view.addSubview(toggleButton)
        appDelegate.queryShuttleRealtimePage()
        openBirthdayDialog()
        NSLayoutConstraint.activate([
            toggleButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            toggleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func toggleButtonClicked(_ sender: UIButton) {
        appDelegate.toggleShowShuttleRemainingTime()
    }
    
    // Polling Query every 1 minute
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Observable<Int>.interval(.seconds(60), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.appDelegate.queryShuttleRealtimePage()
            })
            .disposed(by: disposeBag)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            closestStop(userLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showToast(message: String.localizedItem(resourceID: "location.permission.denied"))
    }

    func closestStop(userLocation:CLLocation){
        var distances = [CLLocationDistance]()
        for location in self.stopLocation {
            let coord = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            distances.append(coord.distance(from: userLocation))
        }
        let closest = distances.min()
        let position = distances.firstIndex(of: closest!)
        self.viewPager.tabbedView.moveToTab(at: position!)
        self.viewPager.pagedView.moveToPage(at: position!)
        locationManager.stopUpdatingLocation()
    }
    
    func openBirthdayDialog() {
        let today = Date.now
        let calendar = Calendar.current
        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)
        let day = calendar.component(.day, from: today)
        if month == 12 && day == 12 {
            let sharedPreferences = UserDefaults.standard
            if sharedPreferences.integer(forKey: "birthdayDialogLastShown") == year {
                return
            }
            let dialog = UIAlertController(title: String.localizedItem(resourceID: "birthday.title"), message: String.localizedItem(resourceID: "birthday.message"), preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: String.localizedItem(resourceID: "birthday.action"), style: .default) { _ in
                self.dismiss(animated: true)
            })
            dialog.addAction(UIAlertAction(title: String.localizedItem(resourceID: "birthday.action.anymore"), style: .default) { _ in
                sharedPreferences.set(year, forKey: "birthdayDialogLastShown")
                self.dismiss(animated: true)
                
            })
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("authorized")
                case .denied:
                    print("denied")
                case .notDetermined:
                    print("notDetermined")
                case .restricted:
                    print("restricted")
                @unknown default:
                    print("unknown")
                }
            }
        }
    }
}
