//
//  ChatDetailViewModel.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation

protocol ChatDetailViewModelDelegate {
    func onSuccess(by useCase: ChatDetailViewModelUseCases)
    func onFailure(error: String)
}

class ChatDetailViewModel: NSObject {
    
    //MARK: - Delegate
    
    var delegate: ChatDetailViewModelDelegate?
    
    // MARK: - Properties
    
    var isValid = true
    var detailChat: User!    
    var uiitems: [ChatDetailUIItem] {
        var items: [ChatDetailUIItem] = []
        items.append(.header(UserChatArgs(userImage: detailChat.image, name: detailChat.name)))
        
        let dateFormatter = DateFormatter()
        if let messages = detailChat.messages {
            return items + messages.map { message in
                let messageDate = getMessageDate(date: message.date, dateFormatter: dateFormatter)
                switch message.status {                    
                case .sent, .error:
                    return .sentMessage(UserChatMessagesArgs(text: message.text, date: messageDate, errorStatus: message.status == .error))
                case .received:
                    return .receivedMessage(UserChatMessagesArgs(text: message.text, date: messageDate, errorStatus: false))
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
    
    // MARK: - Public methods
    
    func sendMessage(value: String) {
        let message = Message(id: 0, userId: detailChat.id, text: value, imagesUrl: nil, date: Date(),
                              type: .textMessage, status: .sent, read: false)
        
        NetworkManager.shared.addMessage(message: message, handler: { status in
            if status {
                var messages = self.detailChat.messages ?? []
                messages.append(message)
                self.detailChat.messages = messages
                self.delegate?.onSuccess(by: .addMessage)
            }
        })
    }
}

