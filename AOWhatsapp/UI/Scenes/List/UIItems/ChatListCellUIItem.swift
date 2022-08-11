//
//  ChatListCellUIItem.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 10/08/22.
//

import Foundation
import UIKit

enum ChatListCellUIItem {
    case header
    case userChat(ChatArgs)
}

struct ChatArgs {
    let userImage: String
    let name: String
    let date: String
    let lastMessage: String
}

