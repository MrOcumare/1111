//
//  NewsTabel.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 24/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit


class NewsTabel : UIViewController {

    var response = ResponseDecoder()
    var counting = 0
    let newsTabel = UITableView()
    var safeArea: UILayoutGuide!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let responseBuffer = fetchData(20, 0) else {
            print("error get array of data")
            return
        }
        response = responseBuffer
        print(response)
        
        navigationItem.title = "Tinkoff News"
        self.navigationController?.navigationBar.barTintColor = .yellow
        safeArea = view.layoutMarginsGuide
        view.addSubview(newsTabel)
        setupTableView()
        newsTabel.delegate = (self as UITableViewDelegate)
        newsTabel.dataSource = (self as UITableViewDataSource)
        newsTabel.register(NewsTabelCell.self, forCellReuseIdentifier: "newsCell")
       
    }
    
    func setupTableView() {
        newsTabel.translatesAutoresizingMaskIntoConstraints = false
        newsTabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        newsTabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        newsTabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        newsTabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    }

}

extension NewsTabel : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (response.response?.news.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTabel.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTabelCell
        cell.label.text = response.response?.news[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        counting += 1
        tableView.reloadData()
    }
}
