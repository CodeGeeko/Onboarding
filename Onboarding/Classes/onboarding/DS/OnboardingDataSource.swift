import Alamofire

struct OnboardingDataSource {
    static func getGeekoOnboardingJSON<Model: Decodable>(for model: Model.Type,
                                                    url: String,
                                                    completion: @escaping (Model?, NSError?) -> Void) {
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

