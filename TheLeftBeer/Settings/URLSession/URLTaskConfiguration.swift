//
//  URLSessionConfiguration.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import Foundation

public struct URLTaskConfiguration {
    
    var session: URLSession
    
    var baseURL: URL
    
    public init(sessionConfiguration: URLSessionConfiguration, baseURL: URL) {
        
        self.init(session: URLSession(configuration: sessionConfiguration),baseURL: baseURL)
    }
    
    public init(session: URLSession, baseURL: URL) {
        
        self.session = session
        self.baseURL = baseURL
    }
}

public extension URLTaskConfiguration {
    
    static let `default` = URLTaskConfiguration(sessionConfiguration: .default, baseURL: URL(string: "https://api.punkapi.com/v2/beers")!)
}
