//
//  UIImage + Ext.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 01.04.2022.
//

import UIKit

extension UIImageView {
    func loadImage(url: String, placeholder: UIImage? = nil) {
        if url == "" {
            self.image = placeholder
        }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + url) else {
        print("invalid url")
        return
      }
      let urlRequest = URLRequest(url: url)
        print(url.absoluteString)
      DispatchQueue.global(qos: .userInitiated).async {  [unowned self] in
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest),
          let image = UIImage(data: cachedResponse.data) {
          self.setImage(image: image)
          return
        }

        URLSession.shared.dataTask(with: urlRequest) {data, response, error in
          if error != nil {
            print("No Image data")
            return
          }
          guard let response = response, let data = data else {
            print("No response data.")
            return
          }
          self.cachedData(response: response, data: data, request: urlRequest)
          guard let image = UIImage(data: data) else {
            print("Not image")
            return
          }
          self.setImage(image: image)
        }.resume()
        
      }
    }
    
    private func cachedData(response: URLResponse, data: Data, request: URLRequest) {
      let cachedResponse = CachedURLResponse(response: response, data: data)
      URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func setImage(image: UIImage) {
      DispatchQueue.main.async {
        self.image = image
      }
    }
}
