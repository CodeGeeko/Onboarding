// MARK: - Discover
struct Tutorial: Codable {
    let tutorials: [TutorialElement]
}

// MARK: - TutorialElement
struct TutorialElement: Codable {
    let teacherName, topicName: String
    let videoBannerURL: String
    let badge: String
    let avgRatings: Double
    let views, kudos, duration: Int
    
    enum CodingKeys: String, CodingKey {
        case teacherName, topicName
        case videoBannerURL = "videoBannerUrl"
        case badge, avgRatings, views, kudos, duration
    }
}

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

