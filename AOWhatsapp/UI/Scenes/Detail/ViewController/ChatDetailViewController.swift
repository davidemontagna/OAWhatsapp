//
//  ChatDetailViewController.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation
import UIKit

protocol ChatDetailViewControllerDelegate: AnyObject {
    func updateUser(value: User)
}

class ChatDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var newMessageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Delegate
    
    weak var delegate: ChatDetailViewControllerDelegate?
    
    // MARK: - Adapter
    
    lazy var adapter = ChatDetailAdapter(delegate: self)
    
    // MARK: - ViewModel
    
    lazy var viewModel = ChatDetailViewModel(delegate: self)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell: SentMessageCell.self)
        tableView.register(cell: SentLinkMessageCell.self)
        tableView.register(cell: ReceivedMessageCell.self)
        tableView.register(cell: ReceivedLinkMessageCell.self)
        tableView.register(cell: ChatHeaderCell.self)        
        adapter.uiitems = viewModel.uiitems
        // Setup TableView
        tableView.delegate = adapter
        tableView.dataSource = adapter
        sendButton.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if let message = newMessageTextField.text {
            viewModel.sendMessage(value: message)
        }
    }
    
    @IBAction func dataChanged(_ sender: Any) {
        if newMessageTextField.text != ""{
            sendButton.isHidden = false
        }
    }
}

// MARK: - Extensions

extension ChatDetailViewController: ChatDetailAdapterDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatDetailViewController: ChatDetailViewModelDelegate {
    func onSuccess(by useCase: ChatDetailViewModelUseCases) {
        switch useCase {
        case .addMessage:
            adapter.uiitems = viewModel.uiitems
            tableView.reloadData()
            sendButton.isHidden = true
            newMessageTextField.text = ""
        }
    }
    
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
