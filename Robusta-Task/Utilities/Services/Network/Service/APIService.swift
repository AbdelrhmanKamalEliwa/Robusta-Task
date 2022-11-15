//
//  APIService.swift
//
//  Created by Abdelrhman Eliwa on 05/07/2021.
//
import Foundation
import Combine
import Security

/// Singleton Class to handle Network Requests
final class APIService: NSObject, APIServiceContract {
    /// Singleton instance of APIService class
    static let shared = APIService()
    
    let progressSubject: PassthroughSubject<(id: Int, progress: Double), Never>
    
    private(set) lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = NetworkConstants.timeoutIntervalForRequest
        return URLSession(configuration: sessionConfig)
    }()
    
    private let serviceQueue: DispatchQueue
    
    private override init() {
        self.progressSubject = .init()
        self.serviceQueue = .init(
            label: "\(EnvironmentManager.shared.string(key: .productBundle)).service",
            qos: .userInteractive,
            attributes: .concurrent
        )
        super.init()
    }
    
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init(),
        retry: Int = NetworkConstants.retries
    ) -> AnyPublisher<T, BaseError> {
        return session
            .dataTaskPublisher(for: request)
            .retry(retry)
            .print()
            .tryMap(\.data)
            .receive(on: serviceQueue)
            .decode(type: responseType.self, decoder: decoder)
            .mapError(handleError(using:))
            .eraseToAnyPublisher()
    }
}

// MARK: - HELPERS
//
private extension APIService {
    func handleError(using error: Error) -> BaseError {
        print("APIService did throw error", error)
        
        switch error {
        case URLError.networkConnectionLost, URLError.notConnectedToInternet:
            return ErrorResolver.shared.getError(for: .connection)
            
        case is URLError:
            return ErrorResolver.shared.getError(for: .unwrappedHttpServer)
            
        case is DecodingError:
            return ErrorResolver.shared.getError(for: .mapping)
            
        default:
            guard let error = error as? BaseError else {
                return ErrorResolver.shared.getError(for: .unexpected)
            }
            return error
        }
    }
}
