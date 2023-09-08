import UIKit
import RxSwift
import QueryAPI

class ShuttleTimetableListItemView: UITableViewCell {
    static let identifier = "ShuttleTimetableListItemView"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(item: ShuttleTimetableItem) {
        let timeValue = item.timetable.time.split(separator: ":")
        let hour = String(timeValue[0])
        let minute = String(timeValue[1])
        timeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_time_format_\(hour)_\(minute)")
        appDelegate.shuttleTimetableQueryParams.subscribe(onNext: { [weak self] params in
            guard let self = self else { return }
            if params?.stopID == "dormitory_o" || params?.stopID == "shuttlecock_o" || params?.stopID == "station" {
                if item.tag == "C" {
                    typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_C")
                    typeLabel.textColor = .darkText
                } else if (item.tag == "DH" || item.tag == "DY") {
                    typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_DH")
                    typeLabel.textColor = .red
                } else {
                    typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_DJ")
                    typeLabel.textColor = .blue
                }
            } else if params?.stopID == "terminal" {
                typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_DY")
                typeLabel.textColor = .darkText
            } else if params?.stopID == "shuttlecock_i" || params?.stopID == "jungang_stn" {
                typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_D")
                typeLabel.textColor = .darkText
            }
        }).disposed(by: disposeBag)
    }
    
    func setupView() {
        addSubview(typeLabel)
        addSubview(timeLabel)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            typeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            typeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}
