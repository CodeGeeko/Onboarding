import UIKit

public class StepProgressView: UIView {
    var view: UIView!

    @IBOutlet weak var progressBarHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var progressStackView: UIStackView!

    private var progressBarHeight: CGFloat = 10.0 {
        didSet {
            progressBarHeightContraint.constant = progressBarHeight
        }
    }

    public var inactiveStepBackgroundColor: UIColor = UIColor(hexString: "4A0BC3")
    public var activeStepBackgroundColor: UIColor = UIColor(hexString: "ffc400")

    private var currentStepBackgroundColor: UIColor {
        return activeStepBackgroundColor.withAlphaComponent(0.5)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    public convenience required init(with totalNumberOfStep: Int, barHeight height: CGFloat) {
        self.init(frame: .zero)
        progressBarHeight = height
        makeProgressView(for: totalNumberOfStep)
    }

    private func setUpView() {
        view = loadViewFromNib()
        view.frame = bounds

        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constrainEdges(to: self)
    }

    /// Loads the activation step view from the nib
    ///
    /// - Returns: The view from the nib
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: StepProgressView.self), bundle: bundle)
        //swiftlint:disable:next force_cast
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return view
    }

    private func makeProgressView(for totalNumberOfSteps: Int) {
        progressStackView.subviews.forEach({ $0.removeFromSuperview() })
        for step in 1...totalNumberOfSteps {
            if step == 1 {
                let leftView = stepView()
                roundLeftEdge(of: leftView)
                progressStackView.addArrangedSubview(leftView)
            } else if step == totalNumberOfSteps {
                let rightView = stepView()
                roundRightEdge(of: rightView)
                progressStackView.addArrangedSubview(rightView)
            } else {
                progressStackView.addArrangedSubview(stepView())
            }
        }
    }
}

// MARK: - Step View
extension StepProgressView {
    private func stepView() -> UIView {
        let view = UIView()
        view.backgroundColor = inactiveStepBackgroundColor
        view.heightAnchor.constraint(equalToConstant: progressBarHeight)
        return view
    }

    func updateProgress(to stepNumber: Int?) {
        for stepView in progressStackView.arrangedSubviews {
            guard let index = progressStackView.arrangedSubviews.index(of: stepView) else { continue }
            if let number = stepNumber, index < number {
                stepView.backgroundColor = index == (number - 1) ? currentStepBackgroundColor : activeStepBackgroundColor
            } else {
                stepView.backgroundColor = inactiveStepBackgroundColor
            }
        }
    }
}

// MARK: - View Rounding
extension StepProgressView {
    private func roundLeftEdge(of view: UIView) {
        round(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], of: view)
    }

    private func roundRightEdge(of view: UIView) {
        round(corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], of: view)
    }

    private func round(corners: CACornerMask, of view: UIView) {
        view.layer.cornerRadius = progressBarHeight / 2.0
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = corners
        } else {
            // Fallback on earlier versions
        }
        view.clipsToBounds = true
    }
}
