import Foundation
import UIKit

class DeveloperViewController: UIViewController {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        return view
    }()

    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12.0
        view.alignment = .fill

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
        label.font = .godo(size: 18.0, weight: .bold)
        label.numberOfLines = 0
        label.text = String.localizedSettingsItem(resourceID: "app.developer")
        return label
    }()
    
    private lazy var nameItem: UIView = {
        let item = UIView()
        let label = UILabel().then {
            $0.font = .godo(size: 14.0, weight: .bold)
            $0.textAlignment = .left
            $0.text = String.localizedSettingsItem(resourceID: "app.developer.name")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        let value = UILabel().then {
            $0.font = .godo(size: 14.0, weight: .medium)
            $0.textAlignment = .right
            $0.text = String.localizedSettingsItem(resourceID: "app.developer.name.value")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        item.addSubview(label)
        item.addSubview(value)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: item.topAnchor),
            label.leftAnchor.constraint(equalTo: item.leftAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: item.bottomAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            
            value.topAnchor.constraint(equalTo: item.topAnchor),
            value.rightAnchor.constraint(equalTo: item.rightAnchor, constant: -16),
            value.bottomAnchor.constraint(equalTo: item.bottomAnchor),
            value.widthAnchor.constraint(equalToConstant: 200),
        ])
        return item
    }()
    
    private lazy var majorItem: UIView = {
        let item = UIView()
        let label = UILabel().then {
            $0.font = .godo(size: 14.0, weight: .bold)
            $0.textAlignment = .left
            $0.text = String.localizedSettingsItem(resourceID: "app.developer.major")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        let value = UILabel().then {
            $0.font = .godo(size: 14.0, weight: .medium)
            $0.textAlignment = .right
            $0.text = String.localizedSettingsItem(resourceID: "app.developer.major.value")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        item.addSubview(label)
        item.addSubview(value)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: item.topAnchor),
            label.leftAnchor.constraint(equalTo: item.leftAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: item.bottomAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            
            value.topAnchor.constraint(equalTo: item.topAnchor),
            value.rightAnchor.constraint(equalTo: item.rightAnchor, constant: -16),
            value.bottomAnchor.constraint(equalTo: item.bottomAnchor),
            value.widthAnchor.constraint(equalToConstant: 200),
        ])
        return item
    }()
    
    
    private lazy var okButton: UIButton? = {
        var configuration = UIButton.Configuration.plain()
        let button = UIButton(configuration: configuration)
        button.setTitle(String.localizedSettingsItem(resourceID: "ok.button"), for: .normal)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()


    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        containerStackView.addArrangedSubview(nameItem)
        containerStackView.addArrangedSubview(majorItem)
        if let lastView = containerStackView.subviews.last {
            containerStackView.setCustomSpacing(24.0, after: lastView)
        }
        containerStackView.addArrangedSubview(buttonStackView)
    }
    
    private func addButtons() {
        buttonStackView.addArrangedSubview(okButton!)
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
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
