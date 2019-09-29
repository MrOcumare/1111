//
//  Fetching.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 25/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import UIKit

func fetchData(_ pageSize: Int, _ pageOffset : Int) -> ResponseDecoder? {
    var newsArray = ResponseDecoder()
    print(pageSize, pageOffset)
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
            semaphore.signal()
        } catch {
            print("error in decode json")
        }
        }.resume()

    semaphore.wait()
    return newsArray
   
}

func fetchNews(_ slug: String) -> String {
    var news = ResponseDecoderNews()
    guard let url = URL(string: "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticle?urlSlug=\(slug)") else {
        print("error")
        return "error: \nPlease check internet connection"
    }
    
    let session = URLSession.shared
    let semaphore = DispatchSemaphore(value: 0)
    session.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            return
        }
        do {
            news = try JSONDecoder().decode(ResponseDecoderNews.self, from: data)
            semaphore.signal()
        } catch {
            print("error in decode json")
        }
        }.resume()
    
    semaphore.wait()
    let string = news.response?.text
    return (StringUtils.cleanHTMLTags(string ?? "error: no test in news"))
}
