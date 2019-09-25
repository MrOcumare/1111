//
//  NewsTabel.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 24/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
public protocol NewsLictControllerDelegate: class {
    func navigateToNewsContoller()
}

var arrayOfNews = [News]()


class NewsTabel : UIViewController {
    
    
    var counting = 0
    lazy var newsTabel = UITableView()
    var safeArea: UILayoutGuide!

    public weak var delegate: NewsLictControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let responseBuffer = fetchData(20, 0) else {
            print("error get array of data")
            return
        }
        
       addInNewsArray(responseBuffer)
        
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
        return arrayOfNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTabel.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTabelCell
        
        cell.label.text = arrayOfNews[indexPath.row].getTitle()
        cell.dateLabel.text = dateStringFormat(arrayOfNews[indexPath.row].getDate())
        cell.counterOfView.text = String(arrayOfNews[indexPath.row].getViewCount())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSegueData.currentSlug = arrayOfNews[indexPath.row].getSlug()
        currentSegueData.currentNews = arrayOfNews[indexPath.row]
        arrayOfNews[indexPath.row].incrimentViewCount()
        tableView.reloadData()
        self.delegate.navigateToNewsContoller()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print()
        let indexPreRefrash = arrayOfNews.count - 1
        if indexPath.row == indexPreRefrash {
            if let newPartArray = fetchData(20, arrayOfNews.count) {
                addInNewsArray(newPartArray)
                tableView.reloadData()
            }
        }
        
    }
   
}


func addInNewsArray(_ decoder : ResponseDecoder) {
    for getStruct in decoder.response!.news {
        let fetchNews = News(id: getStruct.id!, date: getStruct.date!, slug: getStruct.slug!, title: getStruct.title!)
        arrayOfNews.append(fetchNews)
    }
}
