//
//  CountryTableCell.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import UIKit

class CountryTableCell: UITableViewCell {

    static let reuseID  = "CountryCell"
    let flagUrl =  "https://raw.githubusercontent.com/hampusborgos/country-flags/main/png250px"
    
    let countryImageView = MBImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    let countryNameLabel = MBTitleLabel(alignment: .left, fontSize: 20)
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(country : Country) {
        countryNameLabel.text = country.countryName
        let countryUrl = "\(flagUrl)/\(country.countryCode).png".lowercased()
        countryImageView.downloadImage(from: countryUrl)
    }
    
    private func configure() {
        addSubview(countryImageView)
        addSubview(countryNameLabel)
        //set corner radius 
        countryImageView.layer.cornerRadius = countryImageView.frame.width/2.0
        countryImageView.clipsToBounds = true
        
        accessoryType = .disclosureIndicator
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            countryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            countryImageView.heightAnchor.constraint(equalToConstant: 60),
            countryImageView.widthAnchor.constraint(equalToConstant: 60),
            
            countryNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: countryImageView.trailingAnchor, constant: 24),
            countryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
