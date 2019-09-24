//
//  NewsTabel.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 24/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

struct Buffer: Decodable {
    var response : Buffer1
}
struct Buffer1: Decodable {
    var news : [BufferElem]
}
struct BufferElem: Decodable {
    var id : String?
    var title: String?
    var slug: String?
    var text: String?
}

class NewsTabel : UIViewController {

    let newsTabel = UITableView()
    var safeArea: UILayoutGuide!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tinkoff News"
        self.navigationController?.navigationBar.barTintColor = .yellow
        safeArea = view.layoutMarginsGuide
        view.addSubview(newsTabel)
        setupTableView()
        newsTabel.delegate = (self as! UITableViewDelegate)
        newsTabel.dataSource = (self as! UITableViewDataSource)
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTabel.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTabelCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticles?pageSize=2&pageOffset=0") else {
            print("error")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
////                print(response)
//            }
            guard let data = data else {
                return
            }
            do {
                let newsArray = try JSONDecoder().decode(Buffer.self, from: data)
                print("dfsdfs")
                print(newsArray.response.news[0])
            } catch {
                print("dfdf")
            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print(error)
//            }
        }.resume()
    }
}
