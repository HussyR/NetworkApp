//
//  CharacterPage.swift
//  NetworkApp
//
//  Created by Данил on 03.02.2022.
//

import Foundation

struct CharacterPage: Codable {
    let info: Info
    let results: [Character]
}
// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
