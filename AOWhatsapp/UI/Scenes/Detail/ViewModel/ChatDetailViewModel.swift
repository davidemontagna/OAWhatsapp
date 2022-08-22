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
    
    var dateMessage = Date()
    var isValid = true
    var detailChat: User!    
    var uiitems: [ChatDetailUIItem] {
        var items: [ChatDetailUIItem] = []
        items.append(.header(ChatDetailHeaderArgs(userImage: detailChat.image, name: detailChat.name)))
        
        let dateFormatter = DateFormatter()
        if let messages = detailChat.messages {
            return items + messages.map { message in
                chatDetailMessageUIItem(message: message, dateFormatter: dateFormatter)
            }
        }
        return items
    }
    
    // MARK: - ViewModel Lifecycle
    
    init(delegate: ChatDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func chatDetailMessageUIItem (message: Message, dateFormatter: DateFormatter) -> ChatDetailUIItem {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let urls = detector.matches(in: message.text, options: [], range: NSRange(location: 0, length: message.text.utf16.count))
        let messageDate = dateMessage.getMessageHour(date: message.date, dateFormatter: dateFormatter)

        switch message.status {
        case .sent, .error:
            if let url = urls.first {
                if let range = Range(url.range, in: message.text) {
                    let urlStr = message.text[range]
                    return .sentLinkMessage(ChatDetailsMessageWithLinkArgs(url: String(urlStr), date: messageDate, errorStatus: message.status == .error))
                }
            }
            return .sentMessage(ChatDetailsMessageArgs(text: message.text, date: messageDate, errorStatus: message.status == .error))
        case .received:
            if let url = urls.first {
                if let range = Range(url.range, in: message.text) {
                    let urlStr = message.text[range]
                    return .receivedLinkMessage(ChatDetailsMessageWithLinkArgs(url: String(urlStr), date: messageDate, errorStatus: message.status == .error))
                }
            }
            return .receivedMessage(ChatDetailsMessageArgs(text: message.text, date: messageDate, errorStatus: false))
        }
    }
    
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

