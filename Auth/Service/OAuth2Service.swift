import Foundation

final class OAuth2Service {
    static let shared = OAuth2Service()
    private var currentTask: URLSessionTask?
    private var userСode: String?
    private var urlSession = URLSession.shared
    private let storage: OAuth2TokenStorage
    private var task : URLSessionTask?
    
    init(
        urlSession: URLSession = .shared,
        storage: OAuth2TokenStorage = .shared//
    ){
        self.urlSession = urlSession
        self.storage = storage
    }
    
    private (set) var authToken: String? {
        get {
            return storage.token
        }
        set {
            storage.token = newValue
        }
    }
    
    var isAuthenticated: Bool {
        storage.token != nil
    }

    
    func fetchOAuthToken(with code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        assert(Thread.isMainThread)
        guard code != userСode else { return }
        task?.cancel()
        userСode = code
        print("OK", "userСode:",userСode as Any)
        
        guard let request = makeRequest(code: code) else {
            assertionFailure("Error Reguest")
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        task = urlSession.objectTask(for: request) {
            [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self else { return }
            self.task = nil
            switch result {
            case .success(let body):
                let authToken = body.accessToken
                self.storage.token = authToken
                self.userСode = nil
                completion(.success(authToken))
                print(authToken)
            case .failure(let error):
                self.userСode = nil
                completion(.failure(error))
                print(request)
            }
        }
}
    
    func makeRequest(code: String) -> URLRequest? {
        var urlComponents = URLComponents(string: Constants.authTokenURL)
         urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: Constants.requestGrantType)
        ]
        
        guard let urlWithQuery = urlComponents?.url else {
            preconditionFailure("Не удается создать URL с параметрами")
        }
        
        var request = URLRequest(url: urlWithQuery)
        request.httpMethod = Constants.requestMethod
        
        return request
    }
    
    private struct OAuthTokenResponseBody: Codable {
        let accessToken: String
        let tokenType: String
        let scope: String
        let createdAt: Int
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case scope
            case createdAt = "created_at"
        }
    }
}


