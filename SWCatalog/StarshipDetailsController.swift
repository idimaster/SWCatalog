//
//  StarshipDetailsController.swift
//  SWCatalog
//
//  Created by Izumskiy, Dmitry on 10/22/20.
//

import UIKit

class KeyValueViewCell: UITableViewCell {
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
}

class StarshipDetailsController: UIViewController, UITableViewDataSource {
    var info : StarshipInfo? {
        didSet {
            DispatchQueue.main.async {
                self.buildData()
                self.details.reloadData()
                self.activity.stopAnimating()
            }
        }
    }
    var data : [(String, String?)] = []
    
    @IBOutlet weak var details: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activity.startAnimating()
        self.buildData()
        details.dataSource = self
    }
    
    func buildData() {
        data = [];
        data.append(("Name:", info?.name))
        data.append(("Model:", info?.model))
        data.append(("Manufacturer:", info?.manufacturer))
        data.append(("Class:", info?.starship_class))
        data.append(("Cargo:", info?.cargo_capacity))
        data.append(("Consumables:", info?.consumables))
        data.append(("Crew:", info?.crew))
        data.append(("Cost:", info?.cost_in_credits))
        data.append(("Hyperdrive:", info?.hyperdrive_rating))
        data.append(("Length:", info?.length))
        data.append(("MGLT:", info?.MGLT))
        data.append(("Passengers:", info?.passengers))
        data.append(("Atm. speed:", info?.max_atmosphering_speed))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KeyValue", for: indexPath) as! KeyValueViewCell
     
        // set the text from the data model
        cell.key.text = self.data[indexPath.row].0
        cell.value.text = self.data[indexPath.row].1
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
