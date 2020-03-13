//
//  RouteViewController.swift
//  CommuterChronicles
//
//  Created by phrank on 3/5/20.
//  Copyright © 2020 Frank Lenoci. All rights reserved.
//

import UIKit
import CoreLocation
var cords :[CLLocationCoordinate2D] = []
var userimage: UIImage?
var cordss : String = ""


class RouteViewController: UIViewController {
    lazy var geocoder = CLGeocoder()

    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var startText: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!

    @IBOutlet weak var endText: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
 
    @IBOutlet weak var sprite1: UILabel!
    @IBOutlet weak var sprite2: UILabel!
    @IBOutlet weak var sprite3: UILabel!
    
    var i:Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        endText.isHidden = true
        sprite1.isHidden = false
        sprite2.isHidden = true
        sprite3.isHidden = true
        userimage = UIImage(named: "wizard")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sprite1Selected(_ sender: UIButton) {
        sprite1.isHidden = false
        sprite2.isHidden = true
        sprite3.isHidden = true
        userimage = UIImage(named: "wizard")
    }
    @IBAction func sprite2Selected(_ sender: UIButton) {
        sprite1.isHidden = true
        sprite2.isHidden = false
        sprite3.isHidden = true
        userimage = UIImage(named: "priest")
        
    }
    @IBAction func sprite3Selected(_ sender: UIButton) {
        sprite1.isHidden = true
        sprite2.isHidden = true
        sprite3.isHidden = false
      userimage = UIImage(named: "rouge")
    }
    @IBAction func transformAddress(_ sender: UIButton) {
       guard let start = startText.text else {return}
        self.i += 1
        startLabel.isHidden = true
        endText.isHidden = false
        self.startText.text = ""
        self.startText.resignFirstResponder()
        geocoder.geocodeAddressString(start) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        

        
    }

    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {

        if let error = error {
                  print("Unable to Forward Geocode Address (\(error))")

              } else {
                  var location: CLLocation?

                  if let placemarks = placemarks, placemarks.count > 0 {
                      location = placemarks.first?.location
                  }

                  if let location = location {
                    if(self.i == 2)
                    {
                           self.startText.isHidden = true
                           self.startText.resignFirstResponder()
                           self.enterButton.setTitle("Contiune", for: .normal)
                           print(cords)
                           let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let controller = storyboard.instantiateViewController(withIdentifier: "NavView")
                           controller.modalPresentationStyle = .fullScreen
                           self.present(controller, animated: true, completion: nil)
                    }
                    let coordinate = location.coordinate
                    cords.append(coordinate)
                    cordss += "\(coordinate)"
                    //print(cords)
                  } else {
                    print("No Matching Location Found")
                  }
              }
        
        
    }

    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
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
