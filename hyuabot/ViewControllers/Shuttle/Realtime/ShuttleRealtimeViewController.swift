import UIKit

class ShuttleRealtimeViewController: UIViewController {
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fixed(width: 150, height: 60, spacing: 0)
        )
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        
        let view1 = UIView()
        view1.backgroundColor = .red
        
        let view2 = UIView()
        view2.backgroundColor = .blue
        
        let view3 = UIView()
        view3.backgroundColor = .yellow
        
        let view4 = UIView()
        view4.backgroundColor = .green
        
        let view5 = UIView()
        view5.backgroundColor = .purple
        
        let view6 = UIView()
        view6.backgroundColor = .orange
        
        
        viewPager.pagedView.pages = [
            view1,
            view2,
            view3,
            view4,
            view5,
            view6
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String.localizedNavTitle(resourceID: "shuttle.realtime")
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(viewPager)
        
        NSLayoutConstraint.activate([
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            viewPager.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            viewPager.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            viewPager.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
