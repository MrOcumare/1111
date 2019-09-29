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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        dateLabel.text = nil
        counterOfView.text = nil
        viewIconIsUpload.isHidden = true
    }
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textAlignment = .left
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel : UILabel =  {
        let dateLabel = UILabel()
        dateLabel.layer.masksToBounds = true
        dateLabel.font = UIFont(name: "Roboto-Regular", size: 6)
        dateLabel.textAlignment = .left
        dateLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        return dateLabel
    }()
    
    lazy var viewIcon : UIImageView = {
        let icon = UIImage(named: "remove_red_eye-24px")
        let viewIcon = UIImageView(image: icon)
        return viewIcon
    }()
    
    lazy var viewIconIsUpload : UIImageView = {
        let icon = UIImage(named: "isupload")
        let viewIconIsUpload = UIImageView(image: icon)
        viewIconIsUpload.isHidden = true
        return viewIconIsUpload
    }()
    
    lazy var counterOfView : UILabel = {
        let counterOfView = UILabel()
        counterOfView.layer.masksToBounds = true
        counterOfView.font = UIFont(name: "Roboto-Regular", size: 12)
        counterOfView.textAlignment = .left
        return counterOfView
    }()
    
    func setupViews() {
        addSubview(label)
        addSubview(dateLabel)
        addSubview(viewIcon)
        addSubview(counterOfView)
        addSubview(viewIconIsUpload)
        setupLabel()
        setupDateLabel()
        setupIcon()
        setupCounter()
        setupViewIconIsUpload()
        
    }
    
    func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    func setupIcon() {
        viewIcon.translatesAutoresizingMaskIntoConstraints = false
        viewIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        viewIcon.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        viewIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        viewIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupCounter() {
        counterOfView.translatesAutoresizingMaskIntoConstraints = false
        counterOfView.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant:  8).isActive = true
        counterOfView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        counterOfView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    func setupViewIconIsUpload() {
        viewIconIsUpload.translatesAutoresizingMaskIntoConstraints = false
        viewIconIsUpload.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        viewIconIsUpload.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        viewIconIsUpload.heightAnchor.constraint(equalToConstant: 20).isActive = true
        viewIconIsUpload.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
