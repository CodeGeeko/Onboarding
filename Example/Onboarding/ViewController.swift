//
//  ViewController.swift
//  Onboarding
//
//  Created by kuldeep-dvt on 07/29/2021.
//  Copyright (c) 2021 kuldeep-dvt. All rights reserved.
//

import UIKit
import Onboarding

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Landing"
    }
    
    @IBAction func onboardingDidTap(_ sender: Any) {
        launchOnboardingJourney()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController {
    func launchOnboardingJourney() {
        let flowCoordinator = OnboardingFlowNavigationCoordinator(with: self.navigationController ?? UINavigationController())
        flowCoordinator.start(with: .infoSlider, delegate: self)
    }
}

extension ViewController: OnboardingFlowControllerDelegate {
    func didSkipOnboarding() {
        //do nothing for now
    }
    
    func didCompleteOnboarding() {
        //do nothing for now
    }
}
