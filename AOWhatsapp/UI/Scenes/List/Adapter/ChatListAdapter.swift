//
//  ChatListAdapter.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 10/08/22.
//

import Foundation
import UIKit

protocol ChatListAdapterDelegate {
    func onCellSelected(at index: Int)
}

class ChatListAdapter: NSObject {
    
    // MARK: - Delegate
    
    var delegate: ChatListAdapterDelegate?
    
    // MARK: - Properties
    
    var uiitems: [ChatListCellUIItem] = []
    
    // MARK: - Adapter Lifecycle
    
    init(delegate: ChatListAdapterDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Extensions

extension ChatListAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch uiitems[indexPath.row] {
        case .header:
            let cell: NewGroupCell = tableView.dequeueReusableCell(for: NewGroupCell.self, for: indexPath)
            return cell
        case .userChat(let args):
            let cell: ChatListCell = tableView.dequeueReusableCell(for: ChatListCell.self, for: indexPath)
            cell.config(with: args)
            return cell
        }
    }
    
}

extension ChatListAdapter: UITableViewDelegate {
    
}
