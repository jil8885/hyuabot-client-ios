import UIKit

class ShuttleNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    // Configure navigation bar
    func configureNavigationBar(){
        navigationBar.backgroundColor = UIColor(named: "HanyangPrimary")
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
