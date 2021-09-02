class DiscoverContainer: UIViewController {
    @IBOutlet private weak var videoTable: UITableView!
    @IBOutlet private weak var filterBtn: UIButton!
    @IBOutlet private weak var headerImage: UIImageView!
    @IBOutlet private var tableManager: DiscoverTableManager?
    var delegate: OnboardingFlowControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTutorialsContent()
        tableManager?.delegate = self
    }
}
// MARK: - Render
extension DiscoverContainer {
    private func render() {
        setUpScreenComponents()
        setUpNavigationItems()
        populateTableContents()
    }

    private func setUpScreenComponents() {
        let imgHeader = UIImage.bundledImage(for: DiscoverContainer.self, with: "discoveryHeader", bundleName: "Onboarding")
        headerImage.image = imgHeader
        let filterIcon = UIImage.bundledImage(for: DiscoverContainer.self, with: "filterIcon", bundleName: "Onboarding")
        filterBtn.setImage(filterIcon, for: .normal)
        view.bringSubviewToFront(self.videoTable)
    }

    private func setUpNavigationItems() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        let skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 15))
        skipButton.setTitle("Login", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.addTarget(self, action: #selector(loginDidTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: skipButton)
        navigationItem.rightBarButtonItem?.tintColor = .white
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: (65.0/255.0), green: (33.0/255.0), blue: (176.0/255.0), alpha: 1.0)
        self.navigationController?.navigationBar.isHidden = false
    }

    private func populateTableContents() {
        self.tableManager?.setVideos(videos: DiscoverViewModel.shared.videos)
        self.videoTable.reloadData()
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
