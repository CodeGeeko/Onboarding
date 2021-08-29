///TODO: This container should be refactored. The page controller should be managed separately and other minor refactoring needed
///TODO: Loading indicator should be managed by a protocol here
///TODO: The skip journey should be managed by a protocol here
class SliderContainer: UIViewController {

    private var currentIndex: Int = 0
    var delegate: OnboardingFlowControllerDelegate?
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
        let textColor = UIColor(hexString: "4913b6")
        let skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 15))
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(textColor, for: .normal)
        skipButton.addTarget(self, action: #selector(skipDidTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: skipButton)
        navigationItem.rightBarButtonItem?.tintColor = textColor
    }

    private func setUpStyle() {
        pageControl.currentPageIndicatorTintColor = UIColor(hexString: "ffc400")
        pageControl.pageIndicatorTintColor = UIColor(hexString: "4A0BC3")
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
        if let progressBarView = pageControl {
            view.insertSubview(pageViewController.view, belowSubview: progressBarView)
            pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            pageViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            pageViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            pageViewController.view.heightAnchor.constraint(equalToConstant: view.frame.size.height - pageControl.frame.size.height).isActive = true
            if let topAnchor = pageControl?.topAnchor {
                pageViewController.view.bottomAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            }
        }
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func getCurrentSliderContainer() -> UIViewController? {
        guard let sliderInfo = SliderViewModel.shared.sliders?[safe: currentIndex - 1] else { return nil }
        pageControl.currentPage = currentIndex
        return getSliderContainer(with: sliderInfo)
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return SliderViewModel.shared.sliders?.count ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
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
