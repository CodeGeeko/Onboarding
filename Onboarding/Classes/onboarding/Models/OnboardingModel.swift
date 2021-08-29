// MARK: - Onboarding
struct Onboarding: Codable {
    let onboarding: OnboardingClass
}

// MARK: - OnboardingClass
struct OnboardingClass: Codable {
    let sliders: [Slider]
    let interests: [String]
}

// MARK: - Slider
struct Slider: Codable {
    let title, sliderDescription, bannerImageName, infoBackImageName: String
    let pageIndex: Int

    enum CodingKeys: String, CodingKey {
        case title
        case sliderDescription = "description"
        case bannerImageName
        case infoBackImageName
        case pageIndex
    }
}

