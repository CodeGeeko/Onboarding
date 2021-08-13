extension UIImageView {

    func load(path: String, placeholder: UIImage? = nil, cache: URLCache? = nil, success: (() -> Void)? = nil) {
        guard let url = URL(string: path) else { return }
        load(url: url.standardizedFileURL, placeholder: placeholder, cache: cache) {
            success?()
        }
    }

    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil, success: @escaping () -> Void) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
            success()

        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, _) in
                if let data = data,
                    let response = response,
                    ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                    let image = UIImage(data: data) {

                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)

                    DispatchQueue.main.async {
                        self?.image = image
                        success()
                    }
                }
            }).resume()
        }
    }

}

extension UIImage {
    static func bundledImage<Class: NSObject>(for class: Class.Type, with name: String) -> UIImage? {
        let image = UIImage(named: name)
        if image == nil {
            return UIImage(named: name, in: Bundle(for: Class.self), compatibleWith: nil)
        }
        return image
    }
}
