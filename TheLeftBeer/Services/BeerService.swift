//
//  BeerService.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import Foundation
import UIKit

public class BeerService {
    
    var configuration: URLTaskConfiguration
    
    var beerImages: [Int:UIImage?] = [:]
    var beers: [Beer] = []
    var fetchMore = true
    var isfetchingData = false
    var firstLoad = true
    var page = 2

    public init(configuration: URLTaskConfiguration = .default) {
        
        self.configuration = configuration
    }

    public func get(_ page:Int, queue: DispatchQueue = .global(qos: .background), completion: @escaping(Result<[Beer], Error>) -> Void)  {
        
        guard let url = URL(string: "\(configuration.baseURL)?page=\(page)&per_page=25") else {
            completion(.failure(Constants.URLTaskError.invalidURL))
            return
        }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
       
        guard let requestURL = components?.url else {
            
            print("Error Request URL")
            completion(.failure(Constants.URLTaskError.invalidRequestURL))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        self.configuration.session.dataTask(with: request) { (data, response, error) in
            
            do  {
                
                if let error = error {
                    
                    queue.async { completion(.failure(error)) }
                    return
                }
             
                guard let data = data else {
                    
                    queue.async {
                        
                        if page == 1{
                            
                            completion(.failure(Constants.URLTaskError.emptyResponse))
                            
                        }else{
                            
                            completion(.success([]))
                        }
                    }
                    
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let beers = try decoder.decode([Beer].self, from: data)
                queue.async {
                    
                    completion(.success(beers))
                }
                
            } catch let error {
                queue.async {
                    completion(.failure(error)) }
                
            }
        
        }.resume()
    }
}
