//
//  Errors.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/10.
//
//

enum BotError: Swift.Error {
    /*:
     Expect file in `Config/bot-config.json` that looks like the following
     {
     "token": "[your - token - here]"
     }
     */
    case missingConfig(BotConfig)
    
    /*:
     Got an invalid response from RTM api
     */
    case invalidResponse
}
