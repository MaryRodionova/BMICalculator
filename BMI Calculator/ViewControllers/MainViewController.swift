import UIKit
import SnapKit

final class MainViewController: UIViewController {

    private enum Layout {
        static let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        enum Label {
            static let top: CGFloat = 20
            static let height: CGFloat = 500
        }

        enum LabelInfo {
            static let top: CGFloat = 10
        }

        enum Button {
            static let top: CGFloat = 20
            static let height: CGFloat = 80
        }

        enum Image {
            static let top: CGFloat = 0
            static let height: CGFloat = 80
        }
    }

    private var bmi = BMIModel()

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "CALCULATE YOUR BMI"
        label.textColor = .darkGray
        return label
    }()

    private let heightLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Height"
        label.textColor = .darkGray
        return label
    }()

    private let heightInfoLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Question Text"
        label.textColor = .darkGray
        return label
    }()

    private let weightLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Weight"
        label.textColor = .darkGray
        return label
    }()
    
    private let weightInfoLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Question Text"
        label.textColor = .darkGray
        return label
    }()

    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CALCULATE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(hex: "#61609D")
        button.addTarget(
            self,
            action: #selector(didTapCalculateButton),
            for: .touchUpInside
        )
        return button
    }()

    private let heightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor(hex: "#BCBDE6")
        slider.maximumTrackTintColor = .lightGray
        slider.thumbTintColor = UIColor(hex: "#8B8AD1")
        slider.minimumValue = 1
        slider.maximumValue = 2.5
        slider.value = 1.75
        slider.addTarget(
            self,
            action: #selector(heightSliderValueChanged(_:)),
            for: .valueChanged
        )
        return slider
    }()

    private let weightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor(hex: "#BCBDE6")
        slider.maximumTrackTintColor = .lightGray
        slider.thumbTintColor = UIColor(hex: "#8B8AD1")
        slider.minimumValue = 0
        slider.maximumValue = 150
        slider.value = 75
        slider.addTarget(
            self,
            action: #selector(weightSliderValueChanged(_:)),
            for: .valueChanged
        )
        return slider
    }()

    private let imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "calculate_background")
        image.contentMode = .scaleAspectFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupConstraints()

        updateInfoLabel()
    }
    
    @objc
    private func heightSliderValueChanged(_ sender: UISlider) {
        heightInfoLabel.text = "\((heightSlider.value * 100).rounded()/100) m"
    }
    
    @objc
    private func weightSliderValueChanged(_ sender: UISlider) {
        weightInfoLabel.text = "\(Int(weightSlider.value.rounded())) kg"
    }

    @objc
    private func didTapCalculateButton() {
        let heightValue = heightSlider.value
        let weightValue = weightSlider.value
        
        let detailVC = ResultViewController()
        bmi.calculateBMI(height: heightValue, weight: weightValue)
        detailVC.bmiValue = bmi.getBMIValue()
        detailVC.advice = bmi.getAdvice()
        detailVC.color = bmi.getColor()
        present(detailVC, animated: true)
    }

    private func updateInfoLabel() {
        heightInfoLabel.text = "\((heightSlider.value * 100).rounded()/100) m"
        weightInfoLabel.text =  "\(Int(weightSlider.value.rounded())) kg"
        
    }
}

// MARK: - Setup Constraints

private extension MainViewController {
    func addSubviews() {
        view.addSubview(imageBackground)
        view.addSubview(label)
        view.addSubview(heightLabel)
        view.addSubview(heightInfoLabel)
        view.addSubview(heightSlider)
        view.addSubview(weightLabel)
        view.addSubview(weightInfoLabel)
        view.addSubview(weightSlider)
        view.addSubview(calculateButton)
    }

    func setupConstraints() {
        imageBackground.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
            
            make
                .leading.trailing
                .equalToSuperview()
            make
                .bottom
                .equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(Layout.Label.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Label.height)
        }
        
        heightLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(label.snp.bottom)
                .offset(Layout.LabelInfo.top)
            make
                .leading
                .equalToSuperview()
                .inset(Layout.inset)
        }

        heightInfoLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(label.snp.bottom)
                .offset(Layout.LabelInfo.top)
            make
                .trailing
                .equalToSuperview()
                .inset(Layout.inset)
        }

        heightSlider.snp.makeConstraints { make in
            make
                .top
                .equalTo(heightLabel.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
        }
        
        weightLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(heightSlider.snp.bottom)
                .offset(Layout.LabelInfo.top)
            make
                .leading
                .equalToSuperview()
                .inset(Layout.inset)
        }
        
        weightInfoLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(heightSlider.snp.bottom)
                .offset(Layout.LabelInfo.top)
            make
                .trailing
                .equalToSuperview()
                .inset(Layout.inset)
        }
        
        weightSlider.snp.makeConstraints { make in
            make
                .top
                .equalTo(weightLabel.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
        }
        
        calculateButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(weightSlider.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Button.height)
        }
    }
}
