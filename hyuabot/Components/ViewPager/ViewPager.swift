import UIKit

class ViewPager: UIView {
    public let sizeConfiguration: TabbedView.SizeConfiguration
    public let pagedView = PagedView()
    public lazy var tabbedView: TabbedView = {
        let tabbedView = TabbedView(sizeConfiguaration: sizeConfiguration)
        tabbedView.translatesAutoresizingMaskIntoConstraints = false
        return tabbedView
    }()
    
    
    init(tabSizeConfiguration: TabbedView.SizeConfiguration){
        self.sizeConfiguration = tabSizeConfiguration
        super.init(frame: .zero)
        self.setupView()
        tabbedView.delegate = self
        pagedView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(tabbedView)
        self.addSubview(pagedView)
        NSLayoutConstraint.activate([
            tabbedView.topAnchor.constraint(equalTo: self.topAnchor),
            tabbedView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tabbedView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tabbedView.heightAnchor.constraint(equalToConstant: sizeConfiguration.height),
        ])
        NSLayoutConstraint.activate([
            pagedView.topAnchor.constraint(equalTo: tabbedView.bottomAnchor),
            pagedView.leftAnchor.constraint(equalTo: self.leftAnchor),
            pagedView.rightAnchor.constraint(equalTo: self.rightAnchor),
            pagedView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension ViewPager: TabbedViewDelegate {
    func didMoveToTab(at index: Int) {
        self.pagedView.moveToPage(at: index)
    }
}

extension ViewPager: PagedViewDelegate {
    func didMoveToPage(at index: Int) {
        self.tabbedView.moveToTab(at: index)
    }
}
