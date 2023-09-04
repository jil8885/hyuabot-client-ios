import UIKit

class ShuttleRealtimeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String.localizedNavTitle(resourceID: "shuttle.realtime")
        self.view.backgroundColor = .systemBackground
    }
}
