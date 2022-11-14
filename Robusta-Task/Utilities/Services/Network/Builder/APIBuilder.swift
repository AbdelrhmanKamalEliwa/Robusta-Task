//
//  APIBuilder.swift
//
//  Created by Abdelrhman Eliwa on 05/07/2021.
//
import Foundation

public class APIBuilder {
    private(set) var urlRequest: URLRequest
   
    public init() {
        guard let url = URL(string: NetworkConstants.baseUrl) else {
            fatalError("Could not create URL: \(NetworkConstants.baseUrl)")
        }
        self.urlRequest = URLRequest(url: url)
    }
    
    @discardableResult
    public func setHost(using host: String) -> APIBuilder {
        self.urlRequest.url = URL(string: host)
        return self
    }
    
    @discardableResult
    public func setPath(using path: Endpoints) -> APIBuilder {
        self.urlRequest.url = self.urlRequest.url?.appendingPathComponent(path.rawValue)
        return self
    }
    
    @discardableResult
    public func setMethod(using method: HTTPMethod) -> APIBuilder {
        self.urlRequest.httpMethod = method.rawValue
        return self
    }
    
    @discardableResult
    public func setHeaders(using headers: HTTPHeaders) -> APIBuilder {
        for (key, value) in headers {
            self.urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        return self
    }
    
    @discardableResult
    public func setParameters(using parameters: RequestParams) -> APIBuilder {
        switch parameters {
        case .body(let params):
            do {
                self.urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                fatalError("Could not serialize \(params)")
            }

        case .query(let params):
            let queryParams = params.map { pair in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            
            if let url = self.urlRequest.url {
                var components = URLComponents(string: url.absoluteString)
                components?.queryItems = queryParams
                
                self.urlRequest.url = components?.url
            }
        }
        
        return self
    }
  
    public func build() -> URLRequest {
        guard let url = self.urlRequest.url, !url.pathComponents.isEmpty else {
            fatalError("API should contain at least one path.")
        }
        
        return self.urlRequest
    }
}
