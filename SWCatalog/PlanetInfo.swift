//
//  PlanetInfo.swift
//  SWCatalog
//
//  Created by Izumskiy, Dmitry on 10/22/20.
//

import Foundation

let planetsAPI = URL(string: "https://swapi.dev/api/planets")!

struct PlanetInfo : Codable {
    var name = ""
    var rotation_period = ""
    var orbital_period = ""
    var diameter = ""
    var climate = ""
    var gravity = ""
    var terrain = ""
    var surface_water = ""
    var population = ""
    var residents : [URL]
    var url : URL?
}

struct PlanetResponse : Codable {
    var count = 0;
    var next : URL?
    var previous : URL?
    var results : [PlanetInfo]
    
    static func fetch(complationHandler : @escaping (PlanetResponse) -> Void) {
        URLSession.shared.dataTask(with: planetsAPI) {(data, response, error) in
            guard error == nil, let d = data else { return }
            do {
                let resp = try JSONDecoder().decode(PlanetResponse.self, from: d)
                complationHandler(resp)
            } catch let error {
                print(error)
                return
            }
        }
        .resume()
    }
    
    static func fetch(url: URL, complationHandler : @escaping (PlanetInfo) -> Void) {
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil, let d = data else { return }
            do {
                let resp = try JSONDecoder().decode(PlanetInfo.self, from: d)
                complationHandler(resp)
            } catch let error {
                print(error)
                return
            }
        }
        .resume()
    }
}
