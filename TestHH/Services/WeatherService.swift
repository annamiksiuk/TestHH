//
//  WeatherService.swift
//  TestHH
//
//  Created by Anna Miksiuk on 26.01.2019.
//  Copyright © 2019 Anna Miksiuk. All rights reserved.
//

import Foundation

class WeatherService {
    
    private let apiKey = "32b19e7f2755ae7574f5ac1b0036953c"
    private let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    func weather(city: String, complection: @escaping (WeatherModel?) -> Void) {

        guard var url = URLComponents(string: "\(baseURL)/weather") else { complection(nil); return }
        url.queryItems = [URLQueryItem(name: "q", value: city),
                          URLQueryItem(name: "APPID", value: apiKey)]
        
        guard let urlRequest = url.url else { complection(nil); return }
        
        let request = URLRequest(url: urlRequest)
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard error == nil, let data = data else { complection(nil); return }
            do {
                
                let result = try JSONDecoder().decode(WeatherModel.self, from: data)
                complection(result)
                
            } catch {
                complection(nil)
            }
        }.resume()
    }
    
}
