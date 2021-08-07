class DiscoverViewModel {
    private(set) var model: Tutorial?
}

// MARK: Network
extension DiscoverViewModel {
    func fetchOnboardingInfo(with completion: @escaping (_ error: NSError?) -> Void) {
        //TODO: Network code here - From OnboardingDataSource
        OnboardingDataSource.getDiscoverFeeds(for: Tutorial.self, url: "") { info, error in
            if error != nil {
                debugPrint("Error occured:\(String(describing: error?.description))")
                completion(error)
                return
            }
            guard let info = info else { return }
            self.model = info
        }
    }
}
// MARK: Capture Values
extension DiscoverViewModel {
    var screenTitle: String {
        return "Screen Title"
    }
}

// MARK: Capture Objects
extension DiscoverViewModel {
    var videoElements: [TutorialElement] {
        return self.model?.tutorials ?? []
    }
}
