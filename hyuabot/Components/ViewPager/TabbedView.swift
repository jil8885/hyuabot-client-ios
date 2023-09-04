import UIKit

protocol TabbedViewDelegate: AnyObject {
    func didMoveToTab(at index: Int)
}

class TabbedView: UIView {
    weak var delegate: TabbedViewDelegate?
    
    private var currentlySelectedIndex = 0
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: "TabCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    public let sizeConfiguaration: SizeConfiguration
    public var tabs: [TabItemProtocol] {
        didSet {
            self.collectionView.reloadData()
            self.tabs[currentlySelectedIndex].onSelected()
        }
    }
    
    enum SizeConfiguration {
        case fillEqually(height: CGFloat, spacing: CGFloat = 0)
        case fixed(width: CGFloat, height: CGFloat, spacing: CGFloat = 0)
        
        var height: CGFloat {
            switch self {
            case let .fillEqually(height, _):
                return height
            case let .fixed(_, height, _):
                return height
            }
        }
    }
        
    init(sizeConfiguaration: SizeConfiguration, tabs: [TabItemProtocol] = []){
        self.sizeConfiguaration = sizeConfiguaration
        self.tabs = tabs
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    public func moveToTab(at index: Int){
        self.collectionView.scrollToItem(
            at: IndexPath(
                item: index,
                section: 0
            ),
            at: .centeredHorizontally,
            animated: true
        )
        self.tabs[currentlySelectedIndex].onNotselected()
        self.tabs[index].onSelected()
        self.currentlySelectedIndex = index
    }
    
    private func setupView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.collectionView)
        self.collectionView.backgroundColor = UIColor(named: "HanyangPrimary")
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension TabbedView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.sizeConfiguaration {
        case let .fillEqually(height, spacing):
            let totalWidth = self.frame.width - (spacing * CGFloat(self.tabs.count + 1))
            let width = totalWidth / CGFloat(self.tabs.count)
            return CGSize(width: width, height: height)
        case let .fixed(width, height, spacing):
            return CGSize(width: width - (spacing * 2), height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch self.sizeConfiguaration {
            case .fillEqually(_, let spacing):
                return spacing
            case .fixed(_, _, let spacing):
                return spacing
        }
    }
}

extension TabbedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "TabCollectionViewCell", for: indexPath) as! TabCollectionViewCell
        cell.view = self.tabs[indexPath.item]
        return cell
    }
}


extension TabbedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToTab(at: indexPath.item)
        self.delegate?.didMoveToTab(at: indexPath.item)
    }
}
