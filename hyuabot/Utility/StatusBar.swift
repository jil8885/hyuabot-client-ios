import UIKit

extension UIViewController {
    func setStatusBarBackgroundColor(){
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let statusBarManager = window?.windowScene?.statusBarManager
        let statusBarView = UIView(frame: statusBarManager!.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "HanyangPrimary")
        view.addSubview(statusBarView)
    }
}


extension UINavigationController {
    // Configure navigation bar
    func configureNavigationBar(){
        navigationBar.backgroundColor = UIColor(named: "HanyangPrimary")
        let fontAttr = [NSAttributedString.Key.font: UIFont.godo(size: 16), .foregroundColor: UIColor.white]
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = fontAttr
        buttonAppearance.normal.backgroundImage = UIImage().then({
            $0.withTintColor(.white)
        })
        
        let navbarAppearance = UINavigationBarAppearance()
        navbarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.godo(size: 18, weight: .bold)]
        navbarAppearance.buttonAppearance = buttonAppearance
        UINavigationBar.appearance().standardAppearance = navbarAppearance
    }
}
