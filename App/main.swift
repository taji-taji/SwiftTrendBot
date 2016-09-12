import Vapor
import TLS
import HTTP
import Transport
import Foundation

setupClient()

let token = try BotConfig.botToken.load()
let githubToken = try BotConfig.githubToken.load()

let rtmResponse = try BasicClient.loadRealtimeApi(token: token)
guard let webSocketURL = rtmResponse.data["url"]?.string else {
    throw BotError.invalidResponse
}

do {
    try WebSocket.connect(to: webSocketURL) { ws in
        print("Connected to \(webSocketURL)")
        
        ws.onText = { ws, text in
            print("[event] - \(text)")
            
            let event = try JSON(bytes: text.utf8.array)
            guard
                let channel = event["channel"]?.string,
                let text = event["text"]?.string
                else { return }
            
            let components = text.components(separatedBy: " ")
            
            if components[0] == "trending" {
                let language = components[1]
                var message = ""
                
                let github = GitHub(token: githubToken)
                
                do {
                    let res = try github.searchRepositories(language: language)
                    if let items = res.data["items"]?.array {
                        message += "=======================\n"
                        message += "Trending Repositories of *\(language)*\n"
                        message += "- Created after \(github.searchDate)\n"
                        message += "=======================\n\n"
                        message += "\n--------------\n\n"
                        
                        for item in items {
                            guard
                                let full_name = item.object?["full_name"]?.string,
                                let stargazers_count = item.object?["stargazers_count"]?.int
                                else { continue }
                            message += "*\(full_name) (\(stargazers_count))*\n"
                            if let description = item.object?["description"]?.string {
                                message += "\(description)\n"
                            }
                            if let html_url = item.object?["html_url"]?.string {
                                message += "\(html_url)\n"
                            }
                            message += "\n--------------\n\n"
                        }
                    } else if let error = res.data["errors"]?.object, let errorMessage = error["message"]?.string {
                        message = "Error! \(errorMessage)"
                    }
                } catch ProgramStreamError.unsupportedSecurityLayer {
                    message = "Error! Unsupported Security Layer!"
                } catch let error {
                    message = "Error! \(error)"
                }
                
                let response = SlackMessage(to: channel, text: message)
                try ws.send(response)
            }
            
        }
        
        ws.onClose = { ws, _, _, _ in
            print("\n[CLOSED]\n")
        }
    }
} catch let error {
    print(error)
}

let timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { (timer) in
    print(Date())
}
timer
