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

struct GitHub {
    
    let baseURI   = "https://api.github.com/"
    let searchURI = "https://api.github.com/search/"
    var token: String
    
    init(token: String) {
        self.token = token
    }
    
    enum SearchType: String {
        case repositories = "repositories"
        case users        = "users"
    }
    
    func search(type: SearchType, language: String = "swift") throws -> HTTP.Response {
        let headers: [HeaderKey: String] = [
            "Accept": "application/vnd.github.v3.text-match+json",
            "User-Agent": "SwiftTrend"
            ]
        let query: [String: CustomStringConvertible] = [
            "q"           : "language:\(language)+created:>=2016-08-05",
            "sort"        : "stars",
            "order"       : "desc",
            "page"        : 1,
            "per_page"    : 10,
            "access_token": self.token
        ]
        let url: String = "\(searchURI)\(type.rawValue)"
        return try HTTP.Client<TCPClientStream>.get(
            url,
            headers: headers,
            query: query
        )
    }
    
    func searchRepositories(language: String = "swift") throws -> HTTP.Response {
        print(searchRepositories)
        return try search(type: SearchType.repositories, language: language)
    }
    
}
