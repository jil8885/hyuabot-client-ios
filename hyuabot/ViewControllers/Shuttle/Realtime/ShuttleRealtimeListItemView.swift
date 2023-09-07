import UIKit
import RxSwift
import QueryAPI

class ShuttleRealtimeListItemView: UITableViewCell {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    private let isExpanded = BehaviorSubject<Bool>(value: false)
    private let containerView = UIStackView()
    static let identifier = "ShuttleRealtimeListItemView"
    
    private let cellView = ShuttleTableCellView()
    private let detailView = ShuttleTableDetailView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.detailView.isHidden = true
        self.containerView.axis = .vertical
        
        self.contentView.addSubview(containerView)
        self.containerView.addArrangedSubview(cellView)
        self.containerView.addArrangedSubview(detailView)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.cellView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(stopType: ShuttleStop, item: ShuttleArrivalItem) {
        self.cellView.setUI(stopType: stopType, item: item)
    }
}

extension ShuttleRealtimeListItemView {
    var isDetailViewHidden: Bool {
        return self.detailView.isHidden
    }
    
    func showDetailView() {
        self.detailView.isHidden = false
    }
    
    func hideDetailView() {
        self.detailView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
}
