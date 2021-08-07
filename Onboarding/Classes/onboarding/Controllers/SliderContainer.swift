class SliderContainer: UIViewController {
    private var contentProvider: SliderViewModel
    @IBOutlet private weak var pageControl: UIPageControl!
    var pageViewController: OnboardingPageViewController? {
        didSet {
            pageViewController?.pageDelegate = self
        }
    }
    private var delegate: OnboardingFlowControllerDelegate?
    public init(with nibNameOrNil: String? = nil,
                bundle nibBundleOrNil: Bundle? = nil,
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
        fetchSliderContent()
    }
}
// MARK: - Render
extension SliderContainer {
    private func fetchSliderContent() {
        //self.showLoadingView()
        self.contentProvider.fetchSliderContent { (error) in
            //self.hideLoadingView()
            if let error = error {
                print("Error occured:\(error)")
                return
            }
            self.render()
        }
    }
    private func render() {
        setUpStyle()
        setUpNavigationItems()
        setUpSliderPageViewController()
        //pageControl.addTarget(self, action: Selector(("didChangePageControlValue")), for: .valueChanged)
    }
    private func setUpStyle() {
    }
    private func setUpNavigationItems() {
        let textColor = UIColor(red: 73.0/255.0, green: 19.0/255.0, blue: 182.0/255.0, alpha: 1.0)
        let skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 15))
        skipButton.setTitle("Skip", for: .normal)
        skipButton.titleLabel?.tintColor = textColor
        skipButton.tintColor = textColor
        skipButton.addTarget(self, action: #selector(skipDidTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: skipButton)
        navigationItem.rightBarButtonItem?.tintColor = textColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? OnboardingPageViewController {
            self.pageViewController = pageViewController
        }
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        pageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension SliderContainer {
    private func setUpSliderPageViewController() {
        if let sliders = self.contentProvider.sliders {
            pageViewController?.didMove(toParentViewController: self)
            var stepsContollers: [UIViewController] = []
            for slider in sliders {
                guard let sliderFlowController = OnboardingStepFlowFactory.getStepperViewController(viewModel: slider) else { return }
                stepsContollers.append(sliderFlowController)
            }
            self.addPageViewController(with: stepsContollers)
        }
    }

    private func addPageViewController(with viewControllers: [UIViewController]) {
        self.pageViewController?.configure(with: viewControllers)
        //self.insertPageControllerView()
    }

}

extension SliderContainer {
    @objc func skipDidTap() {
        print("Skip Did Tap")
        pageViewController?.scrollToNextViewController()
    }
}
extension SliderContainer: OnboardingPageViewControllerDelegate {
    
    func onboardingPageViewController(onboardingPageViewController: OnboardingPageViewController,
                                      didUpdatePageCount count: Int) {
        //pageControl.numberOfPages = count
    }
    
    func onboardingPageViewController(onboardingPageViewController: OnboardingPageViewController,
                                  didUpdatePageIndex index: Int) {
        //pageControl.currentPage = index
    }
}
