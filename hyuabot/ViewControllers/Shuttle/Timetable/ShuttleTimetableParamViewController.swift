import Foundation
import UIKit

class ShuttleTimetableParamViewController: UIViewController {
    private var period: String = "semester"
    private var stopID: String = "shuttlecock_o"
    private var destination: String = "shuttle_destination_subway"
    private let periodList = ["semester", "vacation_session", "vacation"]
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        return view
    }()

    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12.0
        view.alignment = .center

        return view
    }()

    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 14.0
        view.distribution = .fillEqually

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = String.localizedShuttleItem(resourceID: "shuttle.search.option")
        return label
    }()
    
    private lazy var periodPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()

    
    
    private lazy var okButton: UIButton? = {
        var configuration = UIButton.Configuration.plain()
        let button = UIButton(configuration: configuration)
        button.setTitle(String.localizedShuttleItem(resourceID: "shuttle.search.option.ok"), for: .normal)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton? = {
        var configuration = UIButton.Configuration.plain()
        let button = UIButton(configuration: configuration)
        button.setTitle(String.localizedShuttleItem(resourceID: "shuttle.search.option.cancel"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()


    convenience init(stopID: String, destination: String, period: String? = nil) {
        self.init()
        self.period = period ?? "semester"
        self.stopID = stopID
        self.destination = destination
        modalPresentationStyle = .overFullScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addSubviews()
        addButtons()
        makeConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = true
        }
    }

    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(containerStackView)
        view.backgroundColor = .black.withAlphaComponent(0.2)
    }

    private func addSubviews() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(periodPickerView)
        if let lastView = containerStackView.subviews.last {
            containerStackView.setCustomSpacing(24.0, after: lastView)
        }
        containerStackView.addArrangedSubview(buttonStackView)
    }
    
    private func addButtons() {
        buttonStackView.addArrangedSubview(okButton!)
        buttonStackView.addArrangedSubview(cancelButton!)
    }

    private func makeConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            containerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 32),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -32),

            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            buttonStackView.heightAnchor.constraint(equalToConstant: 48),
            buttonStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor)
        ])
    }
    
    @objc func okButtonTapped() {
        self.appDelegate.queryShuttleTimetablePage(stopID: stopID, destination: destination, period: period)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension ShuttleTimetableParamViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        period = periodList[row]
    }
}

extension ShuttleTimetableParamViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return String.localizedShuttleItem(resourceID: String.LocalizationValue(periodList[row]))
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 40
    }
}

