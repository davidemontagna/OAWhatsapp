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
    
    var users: [User] = [User(id: 0, name: "Davide", image:                                                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Pierre-Person.jpg/800px-Pierre-Person.jpg",
                             messages: [Message(id: 0, userId: 0, text: "Ciao, come va?",
                                                imagesUrl: nil, date: Date.from(2022, 8, 11, 16, 10)!, type: .textMessage,
                                                status: .sent, read: true),
                                        Message(id: 1, userId: 0, text: "Tutto bene, tu?",
                                                imagesUrl: nil, date: Date.from(2022, 8, 11, 16, 11)!, type: .textMessage,
                                                status: .received, read: true),
                                        Message(id: 2, userId: 0, text: "Bene, grazie",
                                                imagesUrl: nil, date: Date.from(2022, 8, 11, 16, 11)!, type: .textMessage,
                                                status: .received, read: true)]),
                         User(id: 1, name: "Mario Rossi", image: "https://www.newidea.com.au/media/104672/untitled-design-16.jpg?width=720&center=0.0,0.0",
                              messages: [Message(id: 0, userId: 0, text: "Ciao, come va?",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 10, 16, 10)!, type: .textMessage,
                                                 status: .sent, read: true),
                                         Message(id: 1, userId: 0, text: "Tutto bene, tu?",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 10, 16, 11)!, type: .textMessage,
                                                 status: .received, read: true),
                                         Message(id: 2, userId: 0, text: "Bene, grazie",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 10, 16, 11)!, type: .textMessage,
                                                 status: .received, read: true)]),
                         User(id: 2, name: "Laura Bianchi", image: "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg",
                              messages: [Message(id: 0, userId: 0, text: "Ciao, come va?",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 9, 16, 10)!, type: .textMessage,
                                                 status: .sent, read: true),
                                         Message(id: 1, userId: 0, text: "Tutto bene, tu?",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 9, 16, 11)!, type: .textMessage,
                                                 status: .received, read: true),
                                         Message(id: 2, userId: 0, text: "Bene, grazie",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 9, 16, 11)!, type: .textMessage,
                                                 status: .received, read: true)]),
                         User(id: 3, name: "Carlo", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgIUF7SE6CROioPfFm3jxwN5cPMxD_MobRdw&usqp=CAU",
                              messages: [Message(id: 0, userId: 0, text: "Ciao, come va?",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 1, 16, 10)!, type: .textMessage,
                                                 status: .sent, read: true),
                                         Message(id: 1, userId: 0, text: "Tutto bene, tu?",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 1, 16, 11)!, type: .textMessage,
                                                 status: .received, read: true),
                                         Message(id: 2, userId: 0, text: "Bene, grazie",
                                                 imagesUrl: nil, date: Date.from(2022, 8, 1, 16, 11)!, type: .textMessage,
                                                 status: .received, read: true)]),
                         User(id: 4, name: "Marco", image: "https://s7g10.scene7.com/is/image/hyundaiautoever/hyundai_luc_donckerwolke_world_car_person_2022-01:Content%20Banner%20Mobile?wid=767&hei=668",
                              messages: nil),
                         User(id: 5, name: "Luca", image: "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                              messages: nil),
                         User(id: 6, name: "Chiara", image: "https://i0.wp.com/current.org/wp-content/uploads/2021/09/lourdes_garcia-navarro-min.jpeg?fit=1170%2C1170&ssl=1",
                              messages: nil),
                         User(id: 7, name: "Gianni", image: "https://upload.wikimedia.org/wikipedia/commons/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg",
                              messages: nil),
                         User(id: 8, name: "Maria", image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                              messages: nil)]
    
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
}


