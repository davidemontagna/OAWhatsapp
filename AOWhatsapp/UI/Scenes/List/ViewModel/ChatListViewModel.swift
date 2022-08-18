//
//  ChatListViewModel.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 10/08/22.
//

import Foundation

protocol ChatListViewModelDelegate: AnyObject {
    func onSuccess(_ type: ChatListViewModelUseCases)
    func onFailure(error: String)
}

class ChatListViewModel: NSObject {
    
    // MARK: - Delegate
    
    weak var delegate: ChatListViewModelDelegate?
    
    // MARK: - Properties
    
    var selectedItemIndex: Int?
    var users: [User] = []
    
    var uiitems: [ChatListCellUIItem] {
        var items: [ChatListCellUIItem] = []
        items.append(.header)
        let dateFormatter = DateFormatter()
        return items + users.map { user in
            var lastMessageText = ""
            var lastMessageDate = ""
            if let messages = user.messages, let lastMessage = messages.last {
                lastMessageText = lastMessage.text
                lastMessageDate = getMessageDate(date: lastMessage.date, dateFormatter: dateFormatter)
            }
            return .userChat(ChatArgs(userImage: user.image,
                                      name: user.name,
                                      date: lastMessageDate,
                                      lastMessage: lastMessageText))
        }
    }
    
    // MARK: - Adapter Lifecycle
    
    init(delegate: ChatListViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func getUsers() {
        NetworkManager.shared.getUsers {(response) in
            self.users = response
            self.delegate?.onSuccess(.getUsers)
        }
    }
    
    // MARK: - Private methods
    
    private func getMessageDate(date: Date, dateFormatter: DateFormatter) -> String {
        let diffComponents = Calendar.current.dateComponents([.day], from: date, to: Date())
        if let days = diffComponents.day {
            if days == 0 {
                dateFormatter.dateFormat = "HH:mm"
                return dateFormatter.string(from: date)
            }
            if days == 1 {
                return "Ieri"
            }
            if days > 7 {
                dateFormatter.dateFormat = "dd/MM/YYYY"
                return dateFormatter.string(from: date)
            }
            if days > 1 {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }            
        }
        return ""
    }
    
    // MARK: - Public methods
    
    func showDetail(for index: Int) {
        selectedItemIndex = index-1
        delegate?.onSuccess(.showChatDetail)
    }
}


