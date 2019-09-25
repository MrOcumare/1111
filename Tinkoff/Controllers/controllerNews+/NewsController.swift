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
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 20)
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var titelView: UILabel = {
        let titelView = UILabel()
        titelView.layer.masksToBounds = true
        titelView.font = UIFont.boldSystemFont(ofSize: 25)
        titelView.textAlignment = .center
        titelView.text = "Тинькофф подписал спонсорский контракт с первой ракеткой России Даниилом Медведевым"
        titelView.numberOfLines = 0
        return titelView
    }()
    
   var safeArea: UILayoutGuide!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        titelView.text = currentSegueData.currentNews?.getTitle()
        var text = ""
        if currentSegueData.currentNews?.getText() == "" {
            text = fetchNews((currentSegueData.currentNews?.getSlug())!)
            currentSegueData.currentNews?.setText(text: text)
        } else {
            text = (currentSegueData.currentNews?.getText())!
        }
        textView.text = text
        
        
        view.addSubview(titelView)
        view.addSubview(textView)
        
        setupTextView()
        setupTitelView()
    }
    
    
    
    func setupTitelView() {
        titelView.translatesAutoresizingMaskIntoConstraints = false
        titelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100 ).isActive = true
        titelView.heightAnchor.constraint(equalToConstant: 200)
        titelView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titelView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300 ).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}
