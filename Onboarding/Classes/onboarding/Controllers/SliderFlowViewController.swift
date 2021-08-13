class SliderFlowViewController: UIViewController {
    var contentProvider: Slider?
    @IBOutlet private weak var onboardingBannerImage: UIImageView!
    @IBOutlet private weak var infoBackImage: UIImageView!
    @IBOutlet private weak var infoContainerView: UIView!
    @IBOutlet private weak var infoTitle: UILabel!
    @IBOutlet private weak var infoDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
}
// MARK: - Render
private extension SliderFlowViewController {
    func render() {
        setUpStyle()
        populateSlide(with: self.contentProvider)
    }

    func setUpStyle() {
        infoTitle.font = .boldSystemFont(ofSize: 32.0)
        infoTitle.textColor = .white
        infoDescription.font = .systemFont(ofSize: 16.0)
        infoDescription.textColor = .white
    }

    func populateSlide(with slider: Slider?) {
        infoTitle.text = slider?.title
        infoDescription.text = slider?.sliderDescription
        onboardingBannerImage.image = UIImage.bundledImage(for: SliderFlowViewController.self, with: slider?.bannerImageName ?? "bannerImage-1")
        infoBackImage.image = UIImage.bundledImage(for: SliderFlowViewController.self, with: slider?.infoBackImageName ?? "infoBackImage-1")
    }
}

extension SliderFlowViewController {
    public func setUpContentProvider(with slider: Slider) {
        self.contentProvider = slider
    }
}
