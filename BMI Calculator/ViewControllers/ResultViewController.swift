import UIKit
import SnapKit

final class ResultViewController: UIViewController {

    private enum Layout {
        static let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        enum Label {
            static let top: CGFloat = 250
            static let leading: CGFloat = 50
            static let height: CGFloat = 50
        
        }

        enum ResultLabel {
            static let top: CGFloat = 20
        }

        enum LabelInfo {
            static let top: CGFloat = 10
        }

        enum Button {
            static let bottom: CGFloat = 20
            static let height: CGFloat = 80
        }

        enum Image {
            static let top: CGFloat = 100
            static let height: CGFloat = 80
        }
    }

    var bmiValue: String?
    var advice: String?
    var color: UIColor?

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "YOUR RESULT"
        return label
    }()

    private let bmilabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private let resultlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "CALCULATE YOUR BMI"
        label.textColor = .lightGray
        return label
    }()

    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RECALCULATE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 12
        button.tintColor = UIColor(hex: "#8B8AD1")
        button.backgroundColor = .white
        button.addTarget(
            self,
            action: #selector(didTapOneButton),
            for: .touchUpInside
        )
        return button
    }()

    private let imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "result_background")
        image.contentMode = .scaleAspectFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupConstraints()

        updateInfo()
    }

    @objc
    private func didTapOneButton() {
        dismiss(animated: true, completion: nil)
    }

    private func updateInfo() {
        bmilabel.text = bmiValue
        resultlabel.text = advice
        view.backgroundColor = color
    }
}

// MARK: - Setup Constraints

private extension ResultViewController {
    func addSubviews() {
        view.addSubview(imageBackground)
        view.addSubview(label)
        view.addSubview(bmilabel)
        view.addSubview(resultlabel)
        view.addSubview(calculateButton)
    }

    func setupConstraints() {
        label.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(Layout.Label.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.Label.leading)
            make
                .height
                .equalTo(Layout.Label.height)
        }

        bmilabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(label.snp.bottom)
                .offset(Layout.ResultLabel.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.Label.leading)
        }

        resultlabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(bmilabel.snp.bottom)
                .offset(Layout.ResultLabel.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
        }

        calculateButton.snp.makeConstraints { make in
            make
                .bottom
                .equalTo(view.snp.bottom)
                .inset(Layout.Button.bottom)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Button.height)
        }

        imageBackground.snp.makeConstraints { make in
            make
                .leading.trailing
                .equalToSuperview()
            make
                .bottom
                .equalToSuperview()
        }
    }
    
}
