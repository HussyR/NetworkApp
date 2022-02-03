//
//  Character.swift
//  NetworkApp
//
//  Created by Данил on 03.02.2022.
//

import Foundation

struct Character : Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    
// Через такое перечисление можно переименовать ключи, но написать нужно все ключи, даже те которые не меняем
//    enum CodingKeys: String, CodingKey {
//        case episodes = "episode"
//        case id
//        case name
//        ...
//        ...
//    }
//
}
