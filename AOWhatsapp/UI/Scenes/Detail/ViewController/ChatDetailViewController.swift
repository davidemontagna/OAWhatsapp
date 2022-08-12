//
//  ChatDetailViewController.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation
import UIKit

class ChatDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Adapter
    
    lazy var adapter = ChatDetailAdapter(delegate: self)
    
    // MARK: - ViewModel
    
    lazy var viewModel = ChatDetailViewModel(delegate: self)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell: SentMessageCell.self)
        tableView.register(cell: ReceivedMessageCell.self)
        tableView.register(cell: ChatHeaderCell.self)
        adapter.uiitems = viewModel.uiitems
        // Setup TableView
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
}

// MARK: - Extensions

extension ChatDetailViewController: ChatDetailAdapterDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatDetailViewController: ChatDetailViewModelDelegate {
    
}
