import UIKit

final class ShuttleFooterView: UIView {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var stopID: ShuttleStop?
    static let identifier = "ShuttleFooterView"
    private let showStopInformationButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var title = AttributedString.init(String.localizedShuttleItem(resourceID: "show.stop.info"))
        title.font = .systemFont(ofSize: 16)
        config.attributedTitle = title
        
        return UIButton(configuration: config, primaryAction: nil)
    }()
    
    init(parentView: UIView) {
        super.init(frame: CGRect(x: 0, y: 0, width: parentView.frame.size.width, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpFooterView(stopID: ShuttleStop){
        showStopInformationButton.translatesAutoresizingMaskIntoConstraints = false
        showStopInformationButton.addTarget(self, action: #selector(clickShowStopInfoButton), for: .touchUpInside)
        self.addSubview(showStopInformationButton)
        self.backgroundColor = .systemBackground
        self.stopID = stopID
        NSLayoutConstraint.activate([
            showStopInformationButton.topAnchor.constraint(equalTo: self.topAnchor),
            showStopInformationButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            showStopInformationButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            showStopInformationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func clickShowStopInfoButton(sender: UIButton){
        appDelegate.shuttleStopQueryParams.onNext(stopID!)
    }
}
