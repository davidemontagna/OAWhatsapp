//
//  ChatDetailAdapter.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation
import UIKit

protocol ChatDetailAdapterDelegate {
    func backButtonTapped()
}

class ChatDetailAdapter: NSObject {
    
    // MARK: - Delegate
    
    var delegate: ChatDetailAdapterDelegate?
    
    // MARK: - Properties
    
    var uiitems: [ChatDetailUIItem] = []
        
    // MARK: - ViewModel Lifecycle
    
    init(delegate: ChatDetailAdapterDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Extensions

extension ChatDetailAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch uiitems[indexPath.row] {
        case .header(let args):
            let cell: ChatHeaderCell = tableView.dequeueReusableCell(for: ChatHeaderCell.self, for: indexPath)
            cell.config(with: self, and: args)
            return cell
        case .sentMessage(let args):
            let cell: ReceivedMessageCell = tableView.dequeueReusableCell(for: ReceivedMessageCell.self, for: indexPath)
            cell.config(with: args)
            return cell
        case .receivedMessage(let args):
            let cell: SentMessageCell = tableView.dequeueReusableCell(for: SentMessageCell.self, for: indexPath)
            cell.config(with: args)
            return cell
        }
    }
}

extension ChatDetailAdapter: UITableViewDelegate {
    
}

extension ChatDetailAdapter: ChatHeaderCellDelegate {
    func backButtonTapped() {
        delegate?.backButtonTapped()
    }
}
