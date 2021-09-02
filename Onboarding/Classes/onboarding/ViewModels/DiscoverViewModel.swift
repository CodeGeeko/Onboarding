// MARK: Network
class DiscoverViewModel {
    static let shared = DiscoverViewModel()
    private var tutorial: Tutorials?
}

extension DiscoverViewModel {
    func fetchTutorialInfo(with completion: @escaping (_ error: NSError?) -> Void) {
        let url = URLConstants.baseUrl_local + URLConstants.discover
        TutorialDataSource.getDiscoverFeeds(for: Tutorials.self, url: url, completion: { info, error in
            if error != nil {
                debugPrint("Error occured:\(String(describing: error?.description))")
                return
            }
            guard let info = info else { return }
            self.tutorial = info
            completion(error)
        })
    }
}
// MARK: Capture Values
extension DiscoverViewModel {
    var screenTitle: String {
        return "Discover"
    }
}

// MARK: Capture Objects
extension DiscoverViewModel {
    var videos: [Tutorial] {
        return self.tutorial?.tutorials ?? []
    }
}
