import UIKit

protocol TabItemProtocol: UIView {
    func onSelected()
    func onNotselected()
}

class TabCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    public var view: TabItemProtocol? {
        didSet {
            self.setupView()
        }
    }
    
    var leftConstraint = NSLayoutConstraint()
    var rightConstraint = NSLayoutConstraint()
    var topConstraint = NSLayoutConstraint()
    var bottomConstraint = NSLayoutConstraint()
    
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0
    ) {
        didSet {
            leftConstraint.constant = contentInsets.left
            rightConstraint.constant = contentInsets.right
            topConstraint.constant = contentInsets.top
            bottomConstraint.constant = contentInsets.bottom
            self.contentView.layoutIfNeeded()
        }
    }
    
    private func setupView(){
        guard let view = self.view else { return }
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        leftConstraint = view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        rightConstraint = view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        topConstraint = view.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        bottomConstraint = view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        NSLayoutConstraint.activate([
            leftConstraint,
            rightConstraint,
            topConstraint,
            bottomConstraint
        ])
    }
}
