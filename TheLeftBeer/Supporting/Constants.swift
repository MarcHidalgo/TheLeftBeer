//
//  Constants.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 9/7/21.
//

import Foundation

struct Constants {
    
    struct CollectionViewCell {
        
        //BeerList
        static let BeerCell = "BeerCollectionViewCell"
    }
    
    struct ViewController {
        
        //BeerList
        static let BeerList = "BeerListViewController"
        static let Empty = "EmptyViewController"
        static let Error = "ErrorViewController"
    }
    
    public enum URLTaskError: Error {
        
        case invalidURL
        case emptyResponse
        case invalidRequestURL
    }

}
