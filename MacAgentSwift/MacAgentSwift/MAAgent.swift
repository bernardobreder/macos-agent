//
//  File.swift
//  MacAgentSwift
//
//  Created by Bernardo Breder on 15/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

import Foundation

class MAAgent {
    
    func sendBroadcastMessage(selector: String, context: [String: String]) {
    }
    
    func sendBroadcastMessage(selector: String, context: [String: String], returning: ([String: String])) {
    }
    
    func sendPrivateMessage(selector: String, context: [String: String]) {
        sendBroadcastMessage(selector, context);
    }
    
    func sendPrivateMessage(selector: String, context: [String: String], returning: ([String: String])) {
    }

}