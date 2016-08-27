//
//  GitHub.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/12.
//
//

import Vapor
import TLS
import HTTP
import Transport
import Foundation

struct GitHub {
    
    static let baseURI   = "https://api.github.com"
    static let searchURI = baseURI + "/search"
    
    var token: String
    
    init(token: String) {
        self.token = token
    }
    
    enum SearchType: String {
        case repositories = "repositories"
        case users        = "users"
        
        var uri: String {
            return searchURI + "/" + self.rawValue
        }
    }

    func searchTrending(type: SearchType, language: String = "swift") throws -> HTTP.Response {
        let yesterday: String = {
            let y = Date(timeIntervalSinceNow: TimeInterval(-60 * 60 * 24))
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: y)
        }()
        let query: [String: CustomStringConvertible] = [
            "q"           : "language:\(language)+created:>=\(yesterday)",
            "sort"        : "stars",
            "order"       : "desc",
            "page"        : 1,
            "per_page"    : 10,
            "access_token": self.token
        ]
        return try search(type: type, query: query)
    }
    
    func search(type: SearchType, query: [String: CustomStringConvertible]) throws -> HTTP.Response {
        let headers: [HeaderKey: String] = [
            "Accept": "application/vnd.github.v3.text-match+json",
            "User-Agent": "SwiftTrend"
            ]
        return try HTTP.Client<TCPClientStream>.get(
            type.uri,
            headers: headers,
            query: query
        )
    }
    
    func searchRepositories(language: String = "swift") throws -> HTTP.Response {
        print("searchRepositories")
        return try searchTrending(type: SearchType.repositories, language: language)
    }
    
    func searchUsers(language: String = "swift") throws -> HTTP.Response {
        print("searchUsers")
        return try searchTrending(type: SearchType.users, language: language)
    }
    
}
