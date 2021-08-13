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
    static func getDiscoverFeeds<Model: Decodable>(for model: Model.Type,
                                                    url: String,
                                                    completion: @escaping (_ data: Model?, _ error: NSError?) -> Void) {
        //TODO: Network call here... Geeko AlamoFire
        Alamofire.request(url).response { response in
            debugPrint(response)
        }
    }
}

public struct URLConstants {
    static let baseUrl_local = "https://api.jsonbin.io/b/"
    static let baseUrl_staging = "http://localhost:8000/"
    static let baseUrl_production = "http://localhost:8000/"
    static let onboarding = "610dab2fe1b0604017a7fd69/3"
    static let login = "authentication"
    static let discover = "610dab46f098011544ac9e99"
}

