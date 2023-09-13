import UIKit

class AppTabItem: UIView, TabItemProtocol {
    private let title: String
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func onSelected() {
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        if indicatorView.superview == nil {
            self.addSubview(indicatorView)
            NSLayoutConstraint.activate([
                indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                indicatorView.leftAnchor.constraint(equalTo: self.leftAnchor),
                indicatorView.rightAnchor.constraint(equalTo: self.rightAnchor),
                indicatorView.heightAnchor.constraint(equalToConstant: 3)
            ])
        }
    }
    
    func onNotselected() {
        self.titleLabel.font = .godo(size: 16, weight: .regular)
        self.layer.shadowOpacity = 0
        indicatorView.removeFromSuperview()
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
