import UIKit
import RxSwift
import QueryAPI

class ReadingRoomListItemView: UITableViewCell {
    static let identifier = "ReadingRoomListItemView"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    private let roomLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private let seatLabel: UILabel = {
        let label = UILabel()
        label.font = .godo(size: 16)
        label.textAlignment = .right
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
        self.contentView.addSubview(roomLabel)
        self.contentView.addSubview(seatLabel)
        
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        seatLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            roomLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            roomLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            roomLabel.widthAnchor.constraint(equalToConstant: 300),
            seatLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            seatLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            seatLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func setUpCell(item: ReadingRoomQuery.Data.ReadingRoom) {
        roomLabel.text = String.localizedReadingRoomItem(resourceID: String.LocalizationValue(String("reading.room.\(item.id)")))
        seatLabel.text = String.localizedReadingRoomItem(resourceID: String.LocalizationValue("reading.room.seat.\(String(item.seats.available)).\(String(item.seats.active))"))
    }
}
