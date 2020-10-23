//
//  PeopleDetailsController.swift
//  SWCatalog
//
//  Created by Izumskiy, Dmitry on 10/22/20.
//

import UIKit

class PersonViewCell: UITableViewCell {
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
}

class PersonHomeViewCell: UITableViewCell {
    @IBOutlet weak var homeworld: UIButton!
}

class PersonStarshipViewCell: UITableViewCell {
    @IBOutlet weak var starship: UIButton!
}

class PeopleDetailsController: UIViewController, UITableViewDataSource {
    var data : [(String, String?)] = []
    var info : PeopleInfo?
    var descriptors = ["Information", "Homeworld", "Starships"]
    
    @IBOutlet weak var details: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildData()
        details.dataSource = self
    }
    
    func buildData() {
        data = [];
        data.append(("Name:", info?.name))
        data.append(("Height:", info?.height))
        data.append(("Mass:", info?.mass))
        data.append(("Hair color:", info?.hair_color))
        data.append(("Skin color:", info?.skin_color))
        data.append(("Eye color:", info?.eye_color))
        data.append(("Birth year:", info?.birth_year))
        data.append(("Gender:", info?.gender))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data.count
     
        case 1:
            return 1
     
        default:
            return info?.starships.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return descriptors.count
     }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return descriptors[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "KeyValue", for: indexPath) as! PersonViewCell
         
            // set the text from the data model
            cell.key.text = self.data[indexPath.row].0
            cell.value.text = self.data[indexPath.row].1
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Homeworld", for: indexPath) as! PersonHomeViewCell
            return cell
     
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Starship", for: indexPath) as! PersonStarshipViewCell
            let path = self.info?.starships[indexPath.row].lastPathComponent ?? "0"
            cell.starship.tag = Int(path) ?? 0
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PlanetDetails") {
            let destinationVC = segue.destination as! PlanetDetailsController
            if let url = info?.homeworld {
                PlanetResponse.fetch(url: url, complationHandler: { (resp) in
                    destinationVC.info = resp
                })
            }
        } else if (segue.identifier == "StarshipDetails") {
            let destinationVC = segue.destination as! StarshipDetailsController
            let button = sender as! UIButton
            StarshipResponse.fetch(id: button.tag, complationHandler: { (resp) in
                destinationVC.info = resp
            })
        }
    }
}
