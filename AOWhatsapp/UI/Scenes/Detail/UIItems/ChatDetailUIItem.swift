//
//  ChaDetailUIItem.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation

enum ChatDetailUIItem {
    case header(UserChatArgs)
    case sentMessage(UserChatMessagesArgs)
    case receivedMessage(UserChatMessagesArgs)
}

struct UserChatArgs {
    let userImage: String
    let name: String
}

struct UserChatMessagesArgs {
    let text: String
    let date: String
    let errorStatus: Bool
}


