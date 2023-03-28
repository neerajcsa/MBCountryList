//
//  MBEmptyStateView.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import UIKit

class MBEmptyStateView: UIView {
    
    let messageLabel = MBTitleLabel(alignment: .center, fontSize: 28)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message : String) {
        super.init(frame: .zero)
        messageLabel.text = message
        
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }

}
