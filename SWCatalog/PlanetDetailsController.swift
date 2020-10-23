//
//  PlanetDetailsController.swift
//  SWCatalog
//
//  Created by Izumskiy, Dmitry on 10/22/20.
//

import UIKit

class PlanetDetailsController: UIViewController {
    
    var info : PlanetInfo? {
        didSet {
            DispatchQueue.main.async {
                self.bind()
            }
        }
    }

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var diameter: UILabel!
    @IBOutlet weak var gravity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    func bind() {
        self.name.text = self.info?.name
        self.population.text = self.info?.population
        self.diameter.text = self.info?.diameter
        self.gravity.text = self.info?.gravity
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
