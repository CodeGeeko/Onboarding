class SliderFlowViewController: UIViewController {
    private var contentProvider: Slider?
    @IBOutlet private weak var onboardingBannerImage: UIImageView!
    @IBOutlet private weak var infoContainerView: UIView!
    @IBOutlet private weak var infoTitle: UILabel!
    @IBOutlet private weak var infoDescription: UILabel!

    public init(nibName nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?,
                contentProvider: Slider) {
        self.contentProvider = contentProvider
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        infoTitle.font = .boldSystemFont(ofSize: 16.0)
        infoTitle.textColor = .white
        infoDescription.font = .systemFont(ofSize: 8.0)
        infoDescription.textColor = .white
    }

    func populateSlide(with slider: Slider?) {
        infoTitle.text = slider?.title
        infoDescription.text = slider?.sliderDescription
        onboardingBannerImage.image = UIImage(named: slider?.bannerImageName ?? "")
    }
}

extension SliderFlowViewController {
    public func setUpContentProvider(with slider: Slider) {
        self.contentProvider = slider
    }
}
