public class OnboardingFlowNavigationCoordinator: NSObject {
    var stepNavigationController: UINavigationController
    
    public init(with stepNavigationController: UINavigationController) {
        self.stepNavigationController = stepNavigationController
        super.init()
    }
    
    public func start(with screen: ScreenType,
                      delegate: OnboardingFlowControllerDelegate? = nil) {
        let viewController = OnboardingStepFlowFactory.viewController(for: screen,
                                                                      with: delegate)
        switch screen {
            case .infoSlider:
                let journey: UINavigationController =  UINavigationController(rootViewController: viewController)
                stepNavigationController.present(journey,
                                                 animated: true,
                                                 completion: nil)
            case .interests, .discover: stepNavigationController.pushViewController(viewController,
                                                                                    animated: true)
        }
    }
    
    public func finish() {
        stepNavigationController.popViewController(animated: true)
    }
}
