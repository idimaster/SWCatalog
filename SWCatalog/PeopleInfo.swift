//
//  PeopleInfo.swift
//  SWCatalog
//
//  Created by Izumskiy, Dmitry on 10/22/20.
//

import Foundation

let peopleAPI = URL(string: "https://swapi.dev/api/people")!

struct PeopleInfo : Codable {
    var name = ""
    var height = ""
    var mass = ""
    var hair_color = ""
    var skin_color = ""
    var eye_color = ""
    var birth_year = ""
    var gender = ""
    var homeworld : URL
    var url : URL
    var starships : [URL]
}

struct PeopleResponse : Codable {
    var count = 0;
    var next : URL?
    var previous : URL?
    var results : [PeopleInfo]
    
    static func fetch(complationHandler : @escaping (PeopleResponse) -> Void) {
        URLSession.shared.dataTask(with: peopleAPI) {(data, response, error) in
            guard error == nil, let d = data else { return }
            do {
                let resp = try JSONDecoder().decode(PeopleResponse.self, from: d)
                complationHandler(resp)
            } catch let error {
                print(error)
                return
            }
        }
        .resume()
    }
    
    static func fetch(id: Int, complationHandler : @escaping (PeopleInfo) -> Void) {
        URLSession.shared.dataTask(with: peopleAPI.appendingPathComponent(String(id))) {(data, response, error) in
            guard error == nil, let d = data else { return }
            do {
                let resp = try JSONDecoder().decode(PeopleInfo.self, from: d)
                complationHandler(resp)
            } catch let error {
                print(error)
                return
            }
        }
        .resume()
    }
}
