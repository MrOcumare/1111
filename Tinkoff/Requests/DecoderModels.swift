//
//  DecoderModels.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 25/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation

//    COMMENT(mrocumare): for get news data
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
    var date: String?
}

//    COMMENT(mrocumare): for get text by slug
struct ResponseDecoderNews: Decodable {
    var response : ElementOfDecoderNews?
}
struct ElementOfDecoderNews: Decodable {
    var text : String?
}
