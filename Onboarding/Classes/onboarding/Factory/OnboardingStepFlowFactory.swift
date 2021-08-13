class OnboardingStepFlowFactory {
    public static func viewController(for screen: ScreenType,
                                      with delegate: OnboardingFlowControllerDelegate? = nil) -> UIViewController {
        return getContainer(with: screen,
                            delegate: delegate)
    }
    static func getStepperViewController(viewModel: Slider) -> UIViewController? {
        let storyboard = UIStoryboard(name: "OnboardingFlow", bundle: Bundle(for: SliderFlowViewController.self))
        let containedViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SliderFlowViewController.self)) as? SliderFlowViewController
        containedViewController?.setUpContentProvider(with: viewModel)
        return containedViewController
    }
}

private extension OnboardingStepFlowFactory {
    static func getContainer(with screen: ScreenType,
                             delegate: OnboardingFlowControllerDelegate? = nil) -> UIViewController {
        switch screen {
            case .infoSlider:
                let storyboard = UIStoryboard(name: "OnboardingFlow",
                                              bundle: Bundle(for: SliderContainer.self))
                guard let containedViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SliderContainer.self)) as? SliderContainer else { return UIViewController() }
                containedViewController.delegate = delegate
                return containedViewController
//                let sliderViewModel = SliderViewModel()
//                let containedViewController = SliderContainer(with: "SliderContainer",
//                                                              bundle: Bundle(for: SliderContainer.self),
//                                                              contentProvider: sliderViewModel)
//
            case .interests:
                let viewModel = SliderViewModel()
                let containedViewController = IntrestsContainer(with: "IntrestsContainer", bundle: .main, contentProvider: viewModel)
                return containedViewController
            case .discover:
                let viewModel = DiscoverViewModel()
                let containedViewController = DiscoverContainer(with: "DiscoverContainer", bundle: .main, contentProvider: viewModel, delegate: delegate)
                return containedViewController
        }
    }
}

public enum ScreenType: Equatable {
    case infoSlider
    case interests
    case discover
}
public enum Direction {
    case forward
    case backward
}
public protocol OnboardingFlowControllerDelegate: class {
    func didSkipOnboarding()
    func didCompleteOnboarding()
}
