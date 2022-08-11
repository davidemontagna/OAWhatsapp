//
//  ViewController.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 10/08/22.
//

import UIKit

class ChatListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Adapter
    
    lazy var adapter = ChatListAdapter(delegate: self)
    
    // MARK: - ViewModel
    
    lazy var viewModel = ChatListViewModel(delegate: self)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell: ChatListCell.self)
        tableView.register(cell: NewGroupCell.self)
        adapter.uiitems = viewModel.uiitems
        // Setup TableView
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
}

// MARK: - Extensions

extension ChatListViewController: ChatListAdapterDelegate {
    func onCellSelected(at index: Int) {

    }
}

extension ChatListViewController: ChatListViewModelDelegate {
    func onSuccess(_ type: ChatListViewModelUseCases) {
        switch type {
        case .getUsers:
            let users = viewModel.users
            if(!users.isEmpty) {
                adapter.uiitems = viewModel.uiitems
                tableView.reloadData()
            }
        }
    }
    
    func onFailure(error: String) {
        func onFailure(error: String) {
            let alert = UIAlertController(title: "Si è verificato un errore",
                                          message: error,
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: { (action: UIAlertAction!) in
                
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}
