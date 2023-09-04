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
        
        // Declare navigation controllers
        let shuttleNC = ShuttleNavigationController.init(rootViewController: shuttleVC)
                
        // Set navigation item for each view controller
        shuttleNC.tabBarItem = UITabBarItem(title: String.localizedNavTitle(resourceID: "shuttle.realtime"), image: UIImage(systemName: "bus"), tag: 0)
        
        // Set view controllers
        self.viewControllers = [shuttleNC]
    }
}

