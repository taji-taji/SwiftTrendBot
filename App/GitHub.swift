//
//  GitHub.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/12.
//
//

import Vapor
import VaporTLS
import HTTP
import Transport

struct GitHub {
    
    static let baseURI = "https://api.github.com/"
    static let searchURI = baseURI + "search/"
    
    enum SearchType: String {
        case repositories = "repositories"
        case users        = "users"
    }
    
    static func search(type: SearchType, language: String = "swift") throws -> HTTP.Response {
        let headers: [HeaderKey: String] = ["Accept": "application/json; charset=utf-8"]
        let query: [String: CustomStringConvertible] = [
            "q": "language:\(language)+created:>=2016-08-05",
            "sort": "stars",
            "order": "desc",
            "page": 1,
            "per_page": 10
        ]
        let url: String = "\(GitHub.searchURI)\(type.rawValue)"
        return try HTTP.Client<TCPClientStream>.get(
            url,
            headers: headers,
            query: query
        )
    }
    
    static func searchRepositories(language: String = "swift") throws -> HTTP.Response {
        return try GitHub.search(type: SearchType.repositories, language: language)
    }
    
}
