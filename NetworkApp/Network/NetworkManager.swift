//
//  NetworkManager.swift
//  NetworkApp
//
//  Created by Данил on 02.02.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static func fetchPage(url: String, completion: @escaping (CharacterPage) -> Void) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            do {
                let charactersPage = try JSONDecoder().decode(CharacterPage.self, from: data)
                completion(charactersPage)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    static func fetchImage(url: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(Thread.isMainThread)
            guard let data = data
            else {return}
            completion(data)
        }.resume()
    }
    
    static func fetchEpisode(url: String, completion: @escaping (Episode) -> Void) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            do {
                let episode = try JSONDecoder().decode(Episode.self, from: data)
                completion(episode)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
}
