//
//  BotConfig.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/27.
//
//

import Vapor

enum BotConfig {
    case botToken
    case githubToken
    case botUserID
    
    func load() throws -> String {
        let config = try Config(prioritized: [.directory(root: workingDirectory + "Config/")])
        switch self {
        case .botToken:
            guard let token = config["bot-config", "token"]?.string else {
                throw BotError.missingConfig(.botToken)
            }
            return token
        case .githubToken:
            guard let githubToken = config["bot-config", "github_token"]?.string else {
                throw BotError.missingConfig(.githubToken)
            }
            return githubToken
        case .botUserID:
            guard let botUserID = config["bot-config", "token"]?.string else {
                throw BotError.missingConfig(.botUserID)
            }
            return botUserID
        }
    }
}
