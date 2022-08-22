//
//  ChaDetailUIItem.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation

enum ChatDetailUIItem {
    case header(ChatDetailHeaderArgs)
    case sentMessage(ChatDetailsMessageArgs)
    case sentLinkMessage(ChatDetailsMessageWithLinkArgs)
    case receivedMessage(ChatDetailsMessageArgs)
    case receivedLinkMessage(ChatDetailsMessageWithLinkArgs)
}

struct ChatDetailHeaderArgs {
    let userImage: String
    let name: String
}

struct ChatDetailsMessageArgs {
    let text: String
    let date: String
    let errorStatus: Bool
}

struct ChatDetailsMessageWithLinkArgs {
    let url: String
    let date: String
    let errorStatus: Bool
}


