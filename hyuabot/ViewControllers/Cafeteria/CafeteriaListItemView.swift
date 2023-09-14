import UIKit
import RxSwift
import QueryAPI

class CafeteriaListItemView: UITableViewCell {
    static let identifier = "CafeteriaListItemView"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(menuLabel)
        self.contentView.addSubview(priceLabel)
        
        menuLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            menuLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            menuLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: self.menuLabel.bottomAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            priceLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
        ])
    }
    
    func setUpCell(item: CafeteriaQuery.Data.Cafeterium.Menu){
        menuLabel.text = item.food
        priceLabel.text = String.localizedCafeteriaItem(resourceID: "food.price.\(item.price)")
    }
}
