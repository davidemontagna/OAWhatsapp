//
//  ReceivedLinkMessageCell.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 12/08/22.
//

import UIKit
import LinkPresentation

class ReceivedLinkMessageCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var triangleImageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Properties
    
    private var provider = LPMetadataProvider()
    private var linkView = LPLinkView()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

   // MARK: - Public methods
    
    func config(with args: ChatDetailsMessageWithLinkArgs) {        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let url = URL(string: args.url)!
        // Re-create the provider
        provider = LPMetadataProvider()
        linkView = LPLinkView(url: url)
        provider.startFetchingMetadata(for: url) { metadata, error in
            guard
                let metadata = metadata,
                error == nil
            else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.linkView.metadata = metadata
            }
        }
        self.stackView.addArrangedSubview(self.linkView)
    }
}
