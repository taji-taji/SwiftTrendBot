//
//  HTTPClient+RTMApi.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/10.
//
//

import Vapor
import TLS
import HTTP
import Transport

extension HTTP.Client {
    static func loadRealtimeApi(token: String, simpleLatest: Bool = true, noUnreads: Bool = true) throws -> HTTP.Response {
        print("loadRealtimeApi")
        let headers: [HeaderKey: String] = ["Accept": "application/json; charset=utf-8"]
        let query: [String: CustomStringConvertible] = [
            "token": token,
            "simple_latest": simpleLatest.queryInt,
            "no_unreads": noUnreads.queryInt
        ]
        return try get(
            "http://slack.com/api/rtm.start",
            headers: headers,
            query: query
        )
    }
}

extension Bool {
    fileprivate var queryInt: Int {
        // slack uses 1 / 0 in their demo
        return self ? 1 : 0
    }
}
