//
//  WebSocket+SlackMessage.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/11.
//
//

import Vapor

extension WebSocket {
    func send(_ node: NodeRepresentable) throws {
        let json = try node.converted(to: JSON.self)
        let message = try json.makeBytes()
        // json MUST send as serialized string
        try send(message.string)
    }
}
