//
//  NewsController.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 25/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit


class NewsController: UIViewController {

    public weak var delegate: NewsLictControllerDelegate!
    
    lazy var scrollView = UIScrollView()
    
    lazy var contentView = UIView()
    
    var safeArea: UILayoutGuide!
    
    lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel : UILabel =  {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.font = UIFont(name: "Roboto-Regular", size: 6)
        label.textAlignment = .left
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tittleLabel)
        contentView.addSubview(textLabel)
        contentView.addSubview(dateLabel)
        
        setupScrollView()
        swtupContentView()
        setupViews()
        setupDate()
        self.view.backgroundColor = .white
        tittleLabel.text = currentSegueData.currentTittle ?? "error and panic in tittle"
        textLabel.text = String((currentSegueData.currentText ?? "error and panic in text")!.filter { !"\n\t\r".contains($0) })
        dateLabel.text = dateStringFormat(currentSegueData.currentDate ?? "00.00.0000")
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func swtupContentView(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(){
        contentView.addSubview(tittleLabel)
        tittleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tittleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        tittleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        
        contentView.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor, constant: 25).isActive = true
        textLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 5/6).isActive = true
    }
    
    func setupDate() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 25).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 5/6).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
