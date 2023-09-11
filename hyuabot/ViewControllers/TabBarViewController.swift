import UIKit

// AppNavigationController is the root tab bar controller of the app.
class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        setStatusBarBackgroundColor()
    }

    func configureNavigationItem() {
        // Declare view controllers
        let shuttleVC = ShuttleRealtimeViewController()
        let busVC = BusRealtimeViewController()
        let subwayVC = SubwayRealtimeViewController()
        
        
        // Declare navigation controllers
        let shuttleNC = ShuttleNavigationController(rootViewController: shuttleVC)
        let busNC = BusNavigationController(rootViewController: busVC)
        let subwayNC = SubwayNavigationController(rootViewController: subwayVC)
        
        
        // Set navigation item for each view controller
        shuttleNC.tabBarItem = UITabBarItem(title: String.localizedNavTitle(resourceID: "shuttle.realtime"), image: UIImage(systemName: "bus"), tag: 0)
        shuttleNC.navigationBar.topItem?.title = String.localizedNavTitle(resourceID: "shuttle.realtime")
        shuttleNC.navigationBar.tintColor = .white
        busNC.tabBarItem = UITabBarItem(title: String.localizedNavTitle(resourceID: "bus.realtime"), image: UIImage(systemName: "bus.doubledecker"), tag: 1)
        busNC.navigationBar.topItem?.title = String.localizedNavTitle(resourceID: "bus.realtime")
        busNC.navigationBar.tintColor = .white
        subwayNC.tabBarItem = UITabBarItem(title: String.localizedNavTitle(resourceID: "subway.realtime"), image: UIImage(systemName: "tram"), tag: 2)
        subwayNC.navigationBar.topItem?.title = String.localizedNavTitle(resourceID: "subway.realtime")
        subwayNC.navigationBar.tintColor = .white
        
        
        // Set view controllers
        self.viewControllers = [shuttleNC, busNC, subwayNC]
    }
}

