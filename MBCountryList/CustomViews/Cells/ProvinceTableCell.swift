//
//  ProvinceTableCell.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import UIKit

class ProvinceTableCell: UITableViewCell {

    static let reuseID  = "ProvinceCell"
    
    let provinceNameLabel = MBTitleLabel(alignment: .left, fontSize: 20)
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(province : Province) {
        provinceNameLabel.text = province.provinceName
    }
    
    private func configure() {
        addSubview(provinceNameLabel)
        
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            provinceNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            provinceNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            provinceNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            provinceNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            provinceNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
        
    }

}
