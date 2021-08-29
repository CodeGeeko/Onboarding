import Alamofire

struct TutorialDataSource {
    static func getDiscoverFeeds<Model: Decodable>(for model: Model.Type,
                                                   url: String,
                                                   completion: @escaping (_ data: Model?, _ error: NSError?) -> Void) {
        //TODO: Network call here... Geeko AlamoFire
        Alamofire.request(url).response { response in
            debugPrint(response)
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let serviceDetail = try decoder.decode(model.self, from: data)
                completion(serviceDetail, nil)
            } catch {
                completion(nil, error as NSError)
            }
        }
    }
}
