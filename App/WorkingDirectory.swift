//
//  WorkingDirectory.swift
//  SwiftTrend
//
//  Created by tajika on 2016/08/10.
//
//

#if os(Linux)
let workingDirectory = "./"
#else
let workingDirectory: String = {
    let parent = #file.characters.split(separator: "/").map(String.init).dropLast().joined(separator: "/")
    let path = "/\(parent)/../"
    return path
}()
#endif
