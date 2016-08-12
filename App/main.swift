import Vapor
import VaporTLS
import HTTP

let config = try Config(workingDirectory: workingDirectory)

guard let token = config["bot-config", "token"].string else {
    throw BotError.missingConfig
}
print(token)

let rtmResponse = try Client.loadRealtimeApi(token: token)
guard let webSocketURL = rtmResponse.data["url"].string else {
    throw BotError.invalidResponse
}

try WebSocket.connect(to: webSocketURL, using: Client<TLSClientStream>.self) { ws in
    print("Connected to \(webSocketURL)")
    
    ws.onText = { ws, text in
        print("[event] - \(text)")
        
        let event = try JSON(bytes: text.utf8.array)
        guard
            let channel = event["channel"]?.string,
            let text = event["text"]?.string
            else { return }
        
        if text.hasPrefix("hello") {
            let response = SlackMessage(to: channel, text: "Hi there 👋")
            print(try? GitHub.searchRepositories())
            try ws.send(response)
        } else if text.hasPrefix("version") {
            let response = SlackMessage(to: channel, text: "Current Version: \(VERSION)")
            try ws.send(response)
        }
    }
    
    ws.onClose = { ws, _, _, _ in
        print("\n[CLOSED]\n")
    }
}
