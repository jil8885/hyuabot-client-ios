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
