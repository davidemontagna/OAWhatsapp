//
//  Messages.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 10/08/22.
//

import Foundation

struct Message {
    let id: Int
    let userId: Int
    let text: String
    let imagesUrl: [String]?
    let date: Date
    let type: MessageType
    let status: MessageStatus
    let read: Bool
}

enum MessageType {
    case textMessage
    case image
}

enum MessageStatus {
    case sent
    case received
}
