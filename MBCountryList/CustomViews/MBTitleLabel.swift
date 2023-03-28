//
//  MBTitleLabel.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import UIKit

class MBTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignment : NSTextAlignment, fontSize : CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }

    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
