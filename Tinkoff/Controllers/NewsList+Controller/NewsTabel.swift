//
//  NewsTabel.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 24/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
import CoreData

public protocol NewsLictControllerDelegate: class {
    func navigateToNewsContoller()
}

var arrayOfNews = [News]()


class NewsTabel : UIViewController {
    
    var user : User!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var safeArea: UILayoutGuide!
    
    lazy var newsTabel = UITableView()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    

    public weak var delegate: NewsLictControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = "user"
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", userName)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                user = User(context: context)
                user.name = userName
                
                guard let responseBuffer = fetchData(20, 0) else { print("error get array of data"); return }
                print(responseBuffer.response?.news.count)
                user.corenews = addInNewsArray(responseBuffer)
                do {
                    try context.save()
                    
                    print(user.corenews?.count)
                    
                } catch let error as NSError {
                    print("error in fers fetch : \(error.userInfo)")
                }
            } else {
                user = results.first
            }
        } catch let error as NSError {
            print(error.userInfo)
        }
        
        
        
        navigationItem.title = "Tinkoff News"
        self.navigationController?.navigationBar.barTintColor = .yellow
        safeArea = view.layoutMarginsGuide
        view.addSubview(newsTabel)
        newsTabel.addSubview(refreshControl)
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
        guard let news = user.corenews else { return 1 }
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTabel.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTabelCell
        
        guard let news = user.corenews?[indexPath.row] as? CoreNews, let tittle = news.tittle, let date = news.date, let viewCount = news.viewCount as? Int16 else {
            print("error")
            return cell
        }
        cell.label.text = tittle
        cell.dateLabel.text = dateStringFormat(date)
        cell.counterOfView.text = String(viewCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsList = user.corenews?.mutableCopy() as? NSMutableOrderedSet
        let newsForAdd = CoreNews(context: context)
        newsForAdd.date = (newsList![indexPath.row] as AnyObject).date
        newsForAdd.slug = (newsList![indexPath.row] as AnyObject).slug
        newsForAdd.id = (newsList![indexPath.row] as AnyObject).id
        newsForAdd.tittle = (newsList![indexPath.row] as AnyObject).tittle
        newsForAdd.viewCount = {
            if (newsList![indexPath.row] as AnyObject).viewCount + 1 < Int16.max {
                return (newsList![indexPath.row] as AnyObject).viewCount + 1
            } else {
                return Int16(0)
            }
        }()
        print(user.corenews![indexPath.row])
        if (user.corenews![indexPath.row] as! CoreNews).text == nil {
            newsForAdd.text = fetchNews((newsList![indexPath.row] as AnyObject).slug!)
        } else {
            newsForAdd.text = (newsList![indexPath.row] as AnyObject).text!
        }
        newsList![indexPath.row] = newsForAdd
        user.corenews = newsList
        do {
            try context.save()
        } catch let error as NSError {
            print("error in download text by slug fetch : \(error.userInfo)")
        }
        currentSegueData.currentText =  (user.corenews![indexPath.row] as AnyObject).text!
        currentSegueData.currentTittle = (user.corenews![indexPath.row] as AnyObject).tittle!
        currentSegueData.currentDate = (user.corenews![indexPath.row] as AnyObject).date!
        tableView.reloadData()
        self.delegate.navigateToNewsContoller()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let indexPreRefrash = user.corenews!.count - 1
        if indexPath.row == indexPreRefrash {
            if let newPartArray = fetchData(20, user.corenews!.count) {
                user.corenews = addInNewsArray(newPartArray)
                do {
                    try context.save()
                } catch let error as NSError {
                    print("error in fers fetch : \(error.userInfo)")
                }

            }
            tableView.reloadData()
        }

    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("refrash")
        
        var i = 0
        var isPullFinish = false
        while isPullFinish == false {
            guard let responseBuffer = fetchData(20, i) else {
                print("error get array of data")
                return
            }
            var bufferList = NSMutableOrderedSet()
            (isPullFinish, i, bufferList) = addInArrayAfterPullRefresh(responseBuffer, i)
            user.corenews = bufferList
            
            do {
                try context.save()
            } catch let error as NSError {
                print("error in pull-to-refrash block : \(error.userInfo)")
            }
        }
        
        
       
        let deadline = DispatchTime.now() + .milliseconds(800)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refreshControl.endRefreshing()
            
        }
        self.newsTabel.reloadData()

       
    }
   
    func addInNewsArray(_ decoder : ResponseDecoder) -> NSMutableOrderedSet {
        let newsList = user.corenews?.mutableCopy() as? NSMutableOrderedSet
        for getStruct in decoder.response!.news  {
            let newsForAdd = CoreNews(context: context)
            newsForAdd.date = getStruct.date!
            newsForAdd.id = getStruct.id!
            newsForAdd.slug = getStruct.slug!
            newsForAdd.viewCount = 0
            newsForAdd.tittle = getStruct.title!
            newsList?.add(newsForAdd)
            
        }
        return newsList!
    }
    
    func addInArrayAfterPullRefresh(_ decoder : ResponseDecoder, _ indexInArrayOfNews : Int) -> (Bool, Int, NSMutableOrderedSet) {
        let newsList = user.corenews?.mutableCopy() as? NSMutableOrderedSet
        var i = indexInArrayOfNews
        for getStruct in decoder.response!.news {
            if getStruct.slug == (newsList![i] as AnyObject).slug {
                return (true, 0, newsList!)
            } else {
                let newsForAdd = CoreNews(context: context)
                newsForAdd.date = getStruct.date!
                newsForAdd.id = getStruct.id!
                newsForAdd.slug = getStruct.slug!
                newsForAdd.viewCount = 0
                newsForAdd.tittle = getStruct.title!
                newsList?.insert(newsForAdd, at: i)
                i = i + 1
            }
        }
        return (false, i, newsList!)
    }
}





