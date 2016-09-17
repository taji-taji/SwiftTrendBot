//
//  SlackMessage.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/11.
//
//

import Node

struct SlackMessage {
    let id: UInt32
    let channel: String
    let text: String
    
    init(to channel: String, text: String) {
        self.id = UInt32.random()
        self.channel = channel
        self.text = text
    }
}

extension SlackMessage: NodeRepresentable {
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "channel": channel,
            "type": "message",
            "text": text
            ]
        )
    }
}
