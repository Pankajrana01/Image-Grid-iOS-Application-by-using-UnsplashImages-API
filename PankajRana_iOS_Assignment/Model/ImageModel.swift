//
//  ImageModel.swift
//  PankajRana_iOS_Assignment
//
//  Created by Pankaj Rana on 13/04/24.
//

import Foundation

struct UnsplashImage: Codable {
    let urls: Urls
    enum CodingKeys: String, CodingKey {
           case urls
       }
}

struct Urls: Codable {
    let regular: String
    
    enum CodingKeys: String, CodingKey {
        case regular
    }
    
    var regularUrl: URL {
        return URL(string: regular)!
    }
}
