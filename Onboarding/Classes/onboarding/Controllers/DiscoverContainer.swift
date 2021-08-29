class DiscoverContainer: UIViewController {
    @IBOutlet private weak var videoTable: UITableView!
    @IBOutlet private weak var filterBtn: UIButton!
    var tableManager: DiscoverTableManager?
    var delegate: OnboardingFlowControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTutorialsContent()
    }
}
// MARK: - Render
extension DiscoverContainer {
    private func render() {
        setUpStyle()
        setUpTableManager()
        setUpNavigationItems()
    }

    private func setUpStyle() {
        
    }

    private func setUpTableManager() {
        let tableManager = DiscoverTableManager(with: self)
        tableManager.setVideos(videos: DiscoverViewModel.shared.videos)
        self.videoTable.delegate = tableManager
        self.videoTable.dataSource = tableManager
    }

    private func setUpNavigationItems() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        let textColor = UIColor(hexString: "000000")
        let skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 15))
        skipButton.setTitle("Login", for: .normal)
        skipButton.setTitleColor(textColor, for: .normal)
        skipButton.addTarget(self, action: #selector(loginDidTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: skipButton)
        navigationItem.rightBarButtonItem?.tintColor = textColor
    }
}

extension DiscoverContainer: VideoInteractable {
    func didSelectVideo(with videoInfo: Any) {
        //do nothing for now
    }
}

extension DiscoverContainer {
    @objc func loginDidTap() {
//        guard let loginContainer = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: String(describing: CGLoginViewController.self)) else { return }
//        loginContainer.delegate = delegate
//
//        let navigator = OnboardingFlowNavigationCoordinator(with: self.navigationController)
//        navigator.pushOrPresent(with: loginContainer, isPush: true)
    }
}

extension DiscoverContainer {
    private func fetchTutorialsContent() {
        DiscoverViewModel.shared.fetchTutorialInfo(with: {(error) in
            if let error = error {
                print("Error occured:\(error)")
                return
            }
            self.render()
        })
    }
}
