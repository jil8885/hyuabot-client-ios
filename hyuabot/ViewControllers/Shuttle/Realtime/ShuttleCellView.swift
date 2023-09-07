import UIKit
import RxSwift

final class ShuttleTableCellView: UIView {
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
    private let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkText
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.appDelegate.showShuttleRemainingTime
            .subscribe(onNext: {(item) in
                if (item) {
                    self.timeLabel.isHidden = true
                    self.remainingTimeLabel.isHidden = false
                } else {
                    self.timeLabel.isHidden = false
                    self.remainingTimeLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(typeLabel)
        addSubview(timeLabel)
        addSubview(remainingTimeLabel)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            typeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            typeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            remainingTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            remainingTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            remainingTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    func setUI(stopType: ShuttleStop, item: ShuttleArrivalItem){
        let timeValue = item.timetable.time.split(separator: ":")
        let hour = String(timeValue[0])
        let minute = String(timeValue[1])
        timeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_time_format_\(hour)_\(minute)")
        remainingTimeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_remaining_time_format_\(Int(item.timetable.remainingTime / 60))")

        if stopType == .dormitoryOut || stopType == .shuttlecockOut {
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
        }
        
        if stopType == .shuttlecockIn || stopType == .jungangStation {
            typeLabel.text = String.localizedShuttleItem(resourceID: "shuttle_tag_D")
            typeLabel.textColor = .darkText
        }
    }
}


final class ShuttleTableDetailView: UIView {
    let lineView = UIView()
    let circleViewList = [UIView(), UIView(), UIView(), UIView(), UIView(), UIView()]
    let stopViewList = [UILabel(), UILabel(), UILabel(), UILabel(), UILabel(), UILabel()]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let lineView = UIView()
        lineView.backgroundColor = .darkGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            lineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            lineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // Create 6 circular views every 20% of the line
        let width = UIScreen.main.bounds.width - 40
        for i in 0..<6 {
            circleViewList[i].backgroundColor = .darkGray
            circleViewList[i].layer.cornerRadius = 5
            circleViewList[i].translatesAutoresizingMaskIntoConstraints = false
            addSubview(circleViewList[i])
            NSLayoutConstraint.activate([
                circleViewList[i].centerYAnchor.constraint(equalTo: lineView.centerYAnchor),
                circleViewList[i].centerXAnchor.constraint(equalTo: lineView.leftAnchor, constant: width * CGFloat(i) / 5),
                circleViewList[i].widthAnchor.constraint(equalToConstant: 10),
                circleViewList[i].heightAnchor.constraint(equalToConstant: 10),
            ])
        }
        
        for i in 0..<6 {
            stopViewList[i].translatesAutoresizingMaskIntoConstraints = false
            addSubview(stopViewList[i])
            NSLayoutConstraint.activate([
                stopViewList[i].topAnchor.constraint(equalTo: circleViewList[i].bottomAnchor, constant: -15),
                stopViewList[i].centerXAnchor.constraint(equalTo: circleViewList[i].centerXAnchor),
                stopViewList[i].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            ])
        }
    }
}
