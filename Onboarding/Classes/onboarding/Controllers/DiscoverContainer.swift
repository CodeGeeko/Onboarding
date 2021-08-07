class DiscoverContainer: UIViewController {
    private var contentProvider: DiscoverViewModel
    var tableManager: DiscoverTableManager
    private var delegate: OnboardingFlowControllerDelegate?
    public init(with nibNameOrNil: String?,
                bundle nibBundleOrNil: Bundle?,
                contentProvider: DiscoverViewModel,
                delegate: OnboardingFlowControllerDelegate? = nil) {
        self.contentProvider = contentProvider
        self.delegate = delegate
        self.tableManager = DiscoverTableManager()
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
extension DiscoverContainer {
    private func render() {
        self.setUpStyle()
        self.setUpTableManager()
        self.setUpScrollView()
        self.renderDownloadAppInfo()
        self.renderAppslist()
    }
    private func renderDownloadAppInfo() {
       
    }
    private func renderAppslist() {
        
    }
    private func setUpStyle() {
        
    }
    private func setUpTableManager() {
        
    }
    private func setUpScrollView() {
    }
}

//MARK: Auto Refresh Based on Scroll
extension DiscoverContainer: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
