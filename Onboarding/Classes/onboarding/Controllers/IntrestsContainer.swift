class IntrestsContainer: UIViewController {
    private var contentProvider: SliderViewModel
    private var delegate: OnboardingFlowControllerDelegate?
    public init(with nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?,
                contentProvider: SliderViewModel,
                delegate: OnboardingFlowControllerDelegate? = nil) {
        self.contentProvider = contentProvider
        self.delegate = delegate
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.render()
    }
}
// MARK: - Render
extension IntrestsContainer {
    private func render() {
        setUp()
    }
    private func setUp() {
        setUpInterestsChips()
    }
    private func setUpInterestsChips() {
        //self.contentProvider.interests
    }
}
