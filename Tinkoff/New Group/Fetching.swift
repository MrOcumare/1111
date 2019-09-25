//
//  Fetching.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 25/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import UIKit

struct ResponseDecoder: Decodable {
    var response : ArrayOfDecoder?
}
struct ArrayOfDecoder: Decodable {
    var news : [ElementOfDecoder]
}
struct ElementOfDecoder: Decodable {
    var id : String?
    var title: String?
    var slug: String?
    var text: String?
}

func fetchData(_ pageSize: Int, _ pageOffset : Int) -> ResponseDecoder? {
    var newsArray = ResponseDecoder()
    print("enter")
    guard let url = URL(string: "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticles?pageSize=\(pageSize)&pageOffset=\(pageOffset)") else {
        print("error")
        return nil
    }
    
    let session = URLSession.shared
    let semaphore = DispatchSemaphore(value: 0)
    session.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            return
        }
        do {
            newsArray = try JSONDecoder().decode(ResponseDecoder.self, from: data)
            print(newsArray)
            semaphore.signal()
        } catch {
            print("error in decode json")
        }
        }.resume()

    semaphore.wait()
    return newsArray
   
}

