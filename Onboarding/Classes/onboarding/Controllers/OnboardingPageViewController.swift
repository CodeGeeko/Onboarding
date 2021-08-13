import UIKit

class OnboardingPageViewController: UIPageViewController {
    weak var pageDelegate: OnboardingPageViewControllerDelegate?

    private(set) lazy var orderedViewControllers: [UIViewController] = []

    public init(with delegate: OnboardingPageViewControllerDelegate? = nil) {
        self.pageDelegate = delegate
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self

        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(viewController: initialViewController)
        }
        pageDelegate?.onboardingPageViewController(onboardingPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    }

    public func configure(with viewControllers: [UIViewController]) {
        orderedViewControllers = []
        for controller in viewControllers {
            orderedViewControllers.append(controller)
        }
    }

    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
           let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(viewController: nextViewController)
        }
    }

    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
           let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }

    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
                           })
    }
    
    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    private func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
           let index = orderedViewControllers.firstIndex(of: firstViewController) {
            pageDelegate?.onboardingPageViewController(onboardingPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}

// MARK: UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
    
}

protocol OnboardingPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter OnboardingPageViewController: the OnboardingPageViewController instance
     - parameter count: the total number of pages.
     */
    func onboardingPageViewController(onboardingPageViewController: OnboardingPageViewController,
                                      didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter OnboardingPageViewController: the OnboardingPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func onboardingPageViewController(onboardingPageViewController: OnboardingPageViewController,
                                      didUpdatePageIndex index: Int)
    
}
