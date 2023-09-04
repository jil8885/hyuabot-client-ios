import UIKit


protocol PagedViewDelegate: AnyObject {
    func didMoveToPage(at index: Int)
}


class PagedView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    public weak var delegate: PagedViewDelegate?
    public var pages: [UIView] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PagedCollectionViewCell.self, forCellWithReuseIdentifier: "PagedCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    
    init(pages: [UIView] = []) {
        self.pages = pages
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:"PagedCollectionViewCell",
            for: indexPath
        ) as! PagedCollectionViewCell
        cell.view = self.pages[indexPath.item]
        return cell
    }
    
    public func moveToPage(at index: Int){
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        self.delegate?.didMoveToPage(at: page)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width,
                      height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 0 }
}
