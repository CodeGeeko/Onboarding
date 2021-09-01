class SliderContainer: UIViewController {

    private var currentIndex: Int = 0
    var delegate: OnboardingFlowControllerDelegate?
    private var progressBarView: StepProgressView?
    var progressBarViewHeight: CGFloat = 20.0
    var progressBarHeightOffset: CGFloat = 1.0
    var progressBarStepHeight: CGFloat = 10.0

    @IBOutlet private weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSliderContent()
    }
}
// MARK: - Render
extension SliderContainer {
    private func fetchSliderContent() {
        SliderViewModel.shared.fetchSliderContent { (error) in
            if let error = error {
                print("Error occured:\(error)")
                return
            }
            self.render()
        }
    }

    private func render() {
        setUpNavigationItems()
        setUpStyle()
        setUpSliderPageViewController()
    }

    private func setUpNavigationItems() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        let skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 15))
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.addTarget(self, action: #selector(skipDidTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: skipButton)
        navigationItem.rightBarButtonItem?.tintColor = .white
        setUpNavigationBarTintColor(with: 1)
    }

    private func setUpStyle() {
        pageControl.currentPageIndicatorTintColor = UIColor(hexString: "ffc400")
        pageControl.pageIndicatorTintColor = UIColor(hexString: "4A0BC3")
    }

    private func setUpNavigationBarTintColor(with stepNumber: Int) {
        self.navigationController?.navigationBar.barTintColor = hexColor(with: stepNumber)
        updateProgressBar(to: stepNumber)
    }
    private func hexColor(with stepNumber: Int) -> UIColor {
        var hexString: String = ""
        switch stepNumber {
            case 1: hexString = "#4320b6"
            case 2: hexString = "#a32bd4"
            case 3: hexString = "#52baee"
            case 4: hexString = "#edca4b"
            default: break
        }
        return UIColor(hexString: hexString)
    }
}

extension SliderContainer {
    private func setUpSliderPageViewController() {
        let pageController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        pageController.delegate = self
        pageController.dataSource = self

        var viewControllers = [UIViewController]()
        if let sliders = SliderViewModel.shared.sliders {
            guard let vc = sliders.first,
                  let viewController = getSliderContainer(with: vc)
                   else { return }
            viewControllers.append(viewController)
        }
        pageController.setViewControllers(viewControllers,
                                          direction: .forward,
                                          animated: false,
                                          completion: nil)
        insertPageControllerView(with: pageController)
    }

    func getSliderContainer(with content: Slider) -> SliderFlowViewController? {
        let viewController = OnboardingStepFlowFactory.getStepperViewController(viewModel: content) as? SliderFlowViewController
        return viewController
    }
    
    private func insertPageControllerView(with pageViewController: UIPageViewController) {
        setUpProgressBar(with: SliderViewModel.shared.sliders?.count ?? 0, stepNumber: 1)
        if let progressBarView = progressBarView {
            view.insertSubview(pageViewController.view, aboveSubview: progressBarView)
            pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            pageViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            pageViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            pageViewController.view.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: progressBarViewHeight).isActive = true
            progressBarView.backgroundColor = .brown
        }
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func getCurrentSliderContainer() -> UIViewController? {
        guard let sliderInfo = SliderViewModel.shared.sliders?[safe: currentIndex - 1] else { return nil }
        pageControl.currentPage = currentIndex
        setUpNavigationBarTintColor(with: currentIndex)
        progressBarView?.backgroundColor = hexColor(with: currentIndex)
        return getSliderContainer(with: sliderInfo)
    }

    private func setUpProgressBar(with numberOfSteps: Int = 0, stepNumber: Int? = 1) {
        guard numberOfSteps > 1 else { return }
        self.progressBarView = StepProgressView(with: numberOfSteps,
                                                barHeight: progressBarStepHeight)
        if let progressView = progressBarView {
            view.insertSubview(progressView, aboveSubview: view)
            progressView.translatesAutoresizingMaskIntoConstraints = false
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            progressView.heightAnchor.constraint(equalToConstant: progressBarViewHeight).isActive = true
            if let bottomAnchor = self.navigationController?.navigationBar.bottomAnchor {
                progressView.topAnchor.constraint(equalTo: bottomAnchor, constant: progressBarHeightOffset).isActive = true
            }
            let separatorView = UIView(frame: CGRect(x: 0,
                                                     y: progressBarViewHeight,
                                                     width: view.frame.size.width,
                                                     height: 1))
            view.insertSubview(separatorView, aboveSubview: view)
            updateProgressBar(to: stepNumber)
        }
    }

    private func updateProgressBar(to stepNumber: Int?) {
        progressBarView?.updateProgress(to: stepNumber)
    }
}

extension SliderContainer {
    @objc func skipDidTap() {
        guard let interestsContainer = OnboardingStepFlowFactory.viewController(for: .interests, with: self) as? IntrestsContainer else { return }
        interestsContainer.setUpContentProvider(with: SliderViewModel.shared.interests ?? [])
        let navigator = OnboardingFlowNavigationCoordinator(with: self.navigationController)
        navigator.pushOrPresent(with: interestsContainer, isPush: true)
    }
}

extension SliderContainer: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let sliderViewController = viewController as? SliderFlowViewController,
              let viewControllerIndex = sliderViewController.contentProvider?.pageIndex,
              let count = SliderViewModel.shared.sliders?.count
        else { return nil }

        currentIndex = viewControllerIndex - 1
        if currentIndex > 0 && currentIndex <= count  {
            return getCurrentSliderContainer()
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let sliderViewController = viewController as? SliderFlowViewController,
              let viewControllerIndex = sliderViewController.contentProvider?.pageIndex,
              let count = SliderViewModel.shared.sliders?.count
        else { return nil }
        print(viewControllerIndex)
        currentIndex = viewControllerIndex + 1
        if currentIndex <= count {
            return getCurrentSliderContainer()
        }
        return nil
    }
}

extension SliderContainer: OnboardingFlowControllerDelegate {
    func didSkipOnboarding() {
        // do nothing for now
    }
    
    func didCompleteOnboarding() {
        // do nothing for now
    }
}
