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
        let cafeteriaVC = CafeteriaViewController()
        let readingRoomVC = ReadingRoomController()
        
        
        // Declare navigation controllers
        let shuttleNC = ShuttleNavigationController(rootViewController: shuttleVC)
        let busNC = BusNavigationController(rootViewController: busVC)
        let subwayNC = SubwayNavigationController(rootViewController: subwayVC)
        let cafeteriaNC = UINavigationController(rootViewController: cafeteriaVC)
        let readingRoomNC = UINavigationController(rootViewController: readingRoomVC)
        cafeteriaNC.navigationBar.backgroundColor = UIColor(named: "HanyangPrimary")
        cafeteriaNC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        readingRoomNC.navigationBar.backgroundColor = UIColor(named: "HanyangPrimary")
        readingRoomNC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
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
        cafeteriaNC.tabBarItem = UITabBarItem(title: String.localizedNavTitle(resourceID: "cafeteria"), image: UIImage(systemName: "fork.knife"), tag: 3)
        cafeteriaNC.navigationBar.topItem?.title = String.localizedNavTitle(resourceID: "cafeteria")
        cafeteriaNC.navigationBar.tintColor = .white
        readingRoomNC.tabBarItem = UITabBarItem(title: String.localizedNavTitle(resourceID: "reading.room"), image: UIImage(systemName: "book"), tag: 4)
        readingRoomNC.navigationBar.topItem?.title = String.localizedNavTitle(resourceID: "reading.room")
        
        // Set view controllers
        self.viewControllers = [shuttleNC, busNC, subwayNC, cafeteriaNC, readingRoomNC]
    }
}

