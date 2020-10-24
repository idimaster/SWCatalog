//
//  PlanetDetailsController.swift
//  SWCatalog
//
//  Created by Izumskiy, Dmitry on 10/22/20.
//

import UIKit

class PlanetViewCell: UITableViewCell {
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
}

class PlanetResidentViewCell: UITableViewCell {
    @IBOutlet weak var resident: UIButton!
}

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

class PlanetDetailsController: UIViewController, UITableViewDataSource {
    let spinner = SpinnerViewController()
    var descriptors = ["Information", "Residents"]
    var data : [(String, String?)] = []
    var info : PlanetInfo? {
        didSet {
            DispatchQueue.main.async {
                self.buildData()
                self.details.reloadData()
                self.spinner.willMove(toParent: nil)
                self.spinner.view.removeFromSuperview()
                self.spinner.removeFromParent()
            }
        }
    }

    @IBOutlet var details: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        self.buildData()
        details.dataSource = self
    }
    
    func buildData() {
        data = [];
        data.append(("Name:", info?.name))
        data.append(("Rotation period:", info?.rotation_period))
        data.append(("Orbital period:", info?.orbital_period))
        data.append(("Diameter:", info?.diameter))
        data.append(("Climate:", info?.climate))
        data.append(("Gravity:", info?.gravity))
        data.append(("Terrain:", info?.terrain))
        data.append(("Surface water:", info?.surface_water))
        data.append(("Population:", info?.population))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data.count
     
        default:
            return info?.residents.count ?? 0
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "KeyValue", for: indexPath) as! PlanetViewCell
         
            // set the text from the data model
            cell.key.text = self.data[indexPath.row].0
            cell.value.text = self.data[indexPath.row].1
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Residents", for: indexPath) as! PlanetResidentViewCell
            let path = self.info?.residents[indexPath.row].lastPathComponent ?? "0"
            cell.resident.setTitle("Resident \(indexPath.row)", for: .normal)
            cell.resident.tag = Int(path) ?? 0
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PeopleDetails") {
            let destinationVC = segue.destination as! PeopleDetailsController
            let button = sender as! UIButton
            PeopleResponse.fetch(id: button.tag, complationHandler: { (resp) in
                destinationVC.info = resp
            })
        }
    }
}
