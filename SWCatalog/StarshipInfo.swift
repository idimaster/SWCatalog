//
//  StarshipInfo.swift
//  SWCatalog
//
//  Created by Izumskiy, Dmitry on 10/22/20.
//

import Foundation

let starshipAPI = URL(string: "https://swapi.dev/api/starships")!

struct StarshipInfo : Codable {
    var name = ""
    var model = ""
    var manufacturer = ""
    var cost_in_credits = ""
    var length = ""
    var max_atmosphering_speed = ""
    var crew = ""
    var passengers = ""
    var cargo_capacity = ""
    var consumables = ""
    var hyperdrive_rating = ""
    var MGLT = ""
    var starship_class = ""
    var url : URL?
}

struct StarshipResponse : Codable {
    var count = 0;
    var next : URL?
    var previous : URL?
    var results : [StarshipInfo]
    
    static func fetch(complationHandler : @escaping (StarshipResponse) -> Void) {
        URLSession.shared.dataTask(with: starshipAPI) {(data, response, error) in
            guard error == nil, let d = data else { return }
            do {
                let resp = try JSONDecoder().decode(StarshipResponse.self, from: d)
                complationHandler(resp)
            } catch let error {
                print(error)
                return
            }
        }
        .resume()
    }
    
    static func fetch(id: Int, complationHandler : @escaping (StarshipInfo) -> Void) {
        URLSession.shared.dataTask(with: starshipAPI.appendingPathComponent(String(id))) {(data, response, error) in
            guard error == nil, let d = data else { return }
            do {
                let resp = try JSONDecoder().decode(StarshipInfo.self, from: d)
                complationHandler(resp)
            } catch let error {
                print(error)
                return
            }
        }
        .resume()
    }
}
