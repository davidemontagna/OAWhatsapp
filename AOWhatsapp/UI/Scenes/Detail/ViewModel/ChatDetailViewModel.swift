//
//  ChatDetailViewModel.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation

protocol ChatDetailViewModelDelegate {
    
}

class ChatDetailViewModel: NSObject {
    
    //MARK: - Delegate
    
    var delegate: ChatDetailViewModelDelegate?
    
    // MARK: - Properties
    
    var detailChat: User!
    
    var uiitems: [ChatDetailUIItem] {
        var items: [ChatDetailUIItem] = []
        items.append(.header(UserChatArgs(userImage: detailChat.image, name: detailChat.name)))
        
        let dateFormatter = DateFormatter()
        if let messages = detailChat.messages {
            return items + messages.map { message in
                let messageDate = getMessageDate(date: message.date, dateFormatter: dateFormatter)
                switch message.status {                    
                case .sent:
                    return .sentMessage(UserChatMessagesArgs(text: message.text, date: messageDate))
                case .received:
                    return .receivedMessage(UserChatMessagesArgs(text: message.text, date: messageDate))
                }
            }
        }
        return items
    }
    
    // MARK: - ViewModel Lifecycle
    
    init(delegate: ChatDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Private methods
    
    private func getMessageDate(date: Date, dateFormatter: DateFormatter) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

