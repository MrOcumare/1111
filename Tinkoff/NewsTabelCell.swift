//
//  NewsTabelCell.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 24/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class NewsTabelCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let label : UILabel = {
        let ageOfPet = UILabel()
        ageOfPet.layer.masksToBounds = true
        ageOfPet.layer.cornerRadius = 12
        ageOfPet.font = UIFont(name: "Roboto-Regular", size: 14)
        ageOfPet.textAlignment = .center
        ageOfPet.text = "2 года"
        return ageOfPet
    }()
    
    func setupViews() {
        addSubview(label)
        setupLabel()
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
}
