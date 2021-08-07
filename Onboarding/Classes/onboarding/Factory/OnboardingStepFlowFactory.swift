class OnboardingStepFlowFactory {
    public static func viewController(for screen: ScreenType,
                               with delegate: OnboardingFlowControllerDelegate? = nil) -> UIViewController {
        return getContainer(with: screen,
                            delegate: delegate)
    }
    static func getStepperViewController(viewModel: Slider) -> UIViewController? {
        let containedViewController = SliderFlowViewController(nibName: "SliderFlowViewController",
                                                               bundle: Bundle(for: SliderFlowViewController.self),
                                                               contentProvider: viewModel)
        return containedViewController
    }
}

private extension OnboardingStepFlowFactory {
    static func getContainer(with screen: ScreenType,
                      delegate: OnboardingFlowControllerDelegate? = nil) -> UIViewController {
        switch screen {
        case .infoSlider:
            let sliderViewModel = SliderViewModel()
            let containedViewController = SliderContainer(with: "SliderContainer",
                                                                bundle: Bundle(for: SliderContainer.self),
                                                                contentProvider: sliderViewModel)
            return containedViewController
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
