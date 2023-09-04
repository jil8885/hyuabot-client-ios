import UIKit

class PagedCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    public var view: UIView? {
        didSet {
            self.setupView()
        }
    }
    
    private func setupView(){
        guard let view = self.view else { return }
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        ])
    }
}
