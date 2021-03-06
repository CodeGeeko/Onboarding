class SliderViewModel {
    static let shared = SliderViewModel()
    private var slider: Onboarding?
}

// MARK: Network
extension SliderViewModel {
    func fetchSliderContent(with completion: @escaping (_ error: NSError?) -> Void) {
        let url = URLConstants.baseUrl_local + URLConstants.onboarding
        OnboardingDataSource.getGeekoOnboardingJSON(for: Onboarding.self, url: url) { info, error in
            if error != nil {
                debugPrint("Error occured:\(String(describing: error?.description))")
                return
            }
            guard let info = info else { return }
            self.slider = info
            completion(error)
        }
    }
}
// MARK: Capture Values
extension SliderViewModel {
    var screenTitle: String {
        return "Screen Title"
    }

    func title(for slideAtIndex: Int) -> String? {
        return self.slider?.onboarding.sliders[slideAtIndex].title
    }

    func description(for slideAtIndex: Int) -> String? {
        return self.slider?.onboarding.sliders[slideAtIndex].sliderDescription
    }

    func bannerImageUrl(for slideAtIndex: Int) -> String? {
        return self.slider?.onboarding.sliders[slideAtIndex].bannerImageName
    }

    var interests: [String]? {
        return self.slider?.onboarding.interests
    }

    var sliders: [Slider]? {
        return self.slider?.onboarding.sliders
    }
}
