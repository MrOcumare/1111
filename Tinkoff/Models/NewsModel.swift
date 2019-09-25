//
//  NewsModel.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 25/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation



class News {
    private var id : String
    private var date : String
    private var text : String
    private var title : String
    private var slug : String
    private var viewCount : Int
    
    init (id: String, date: String, slug: String, title: String) {
        self.id = id
        self.date = date
        self.slug = slug
        self.title = title
        self.text = ""
        self.viewCount = 0
    }
    
    init () {
        self.id = ""
        self.date = ""
        self.text = ""
        self.title = ""
        self.slug = ""
        self.viewCount = 0
    }
    
    public func incrimentViewCount() {
        self.viewCount += 1
    }
    
    public func getId() -> String {
        return self.id
    }
    
    public func getDate() -> String {
        return self.date
    }
    
    public func getText() -> String {
        return self.text
    }
    
    public func getSlug() -> String {
        return self.slug
    }
    
    public func getViewCount() -> Int {
        return self.viewCount
    }
    
    public func getTitle() -> String {
        return self.title
    }
    
    public func setText(text : String) {
        self.text = text
    }
    
}


