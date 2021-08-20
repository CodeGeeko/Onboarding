public class OnboardingFlowNavigationCoordinator: NSObject {
    var stepNavigationController: UINavigationController?
    
    public init(with stepNavigationController: UINavigationController? = UINavigationController()) {
        self.stepNavigationController = stepNavigationController
        super.init()
    }

    public func start(with screen: ScreenType,
                      delegate: OnboardingFlowControllerDelegate? = nil) {
        let viewController = OnboardingStepFlowFactory.viewController(for: screen,
                                                                      with: delegate)
        stepNavigationController?.pushViewController(viewController,
                                                    animated: true)
    }

    func finish() {
        stepNavigationController?.popViewController(animated: true)
    }

    func pushOrPresent(with controller: UIViewController, isPush: Bool = true) {
        isPush ? (stepNavigationController?.pushViewController(controller,
            animated: true)) :
            (stepNavigationController?.present(controller,
                                              animated: true,
                                              completion: nil))
    }
}
