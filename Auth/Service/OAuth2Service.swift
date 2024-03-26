import Foundation

final class OAuth2Service {
    
    private var currentTask: URLSessionTask?
    private var userСode: String?
    private var urlSession = URLSession.shared
    private let storage: OAuth2TokenStorage
    private var task : URLSessionTask?
    private let responseBody: OAuthTokenResponseBody
    
    init(
        urlSession: URLSession = .shared,
        storage: OAuth2TokenStorage = .shared,
        responseBody: OAuthTokenResponseBody = .shared
    ){
        self.urlSession = urlSession
        self.storage = storage
        self.responseBody = responseBody
    }
    
    private (set) var authToken: String? {
        get {
            return storage.token
        }
        set {
            storage.token = newValue
        }
    }
    
    func fetchOAuthToken(with code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        assert(Thread.isMainThread)
        guard code != userСode else { return }
        task?.cancel()
        
        guard let request = makeRequest(code: code) else {
            assertionFailure("Error Reguest")
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        task = urlSession.objectTask(for: request) {
            [weak self] (result: Result<OAuthTokenResponseBody.ResponseBody, Error>) in
            guard let self else { return }
            self.task = nil
            switch result {
            case .success(let body):
                let authToken = body.accessToken
                self.storage.token = authToken
                self.userСode = nil
                completion(.success(authToken))
            case .failure(let error):
                self.userСode = nil
                completion(.failure(error))
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
}
