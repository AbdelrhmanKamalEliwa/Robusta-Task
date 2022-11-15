//
//  ImageLoader.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import UIKit
import Combine

class ImageLoader: ObservableObject {
    // MARK: - PROPERTIES
    //
    private let url: String?
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    // MARK: - INIT
    //
    init(url: String?) {
        self.url = url
    }
    
    // MARK: - METHODS
    //
    func fetch() {
        guard image == nil, !isLoading else {
            return
        }
        
        guard let url = url, let fetchURL = URL(string: url) else {
            errorMessage = ErrorType.mapping.message
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self.errorMessage = ErrorType.unwrappedHttpServer.message
                } else if let data = data, let image = UIImage(data: data) {
                    self.image = image
                } else {
                    self.errorMessage = ErrorType.unexpected.message
                }
                
            }
        }
        
        task.resume()
    }
}
