//
//  RouteViewController.swift
//  CommuterChronicles
//
//  Created by phrank on 3/5/20.
//  Copyright © 2020 Frank Lenoci. All rights reserved.
//

import UIKit
import CoreLocation

class RouteViewController: UIViewController {
    lazy var geocoder = CLGeocoder()

    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var startText: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!

    @IBOutlet weak var endText: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var locationText: UITextView!
  
    var i:Int = 0
    var cords :[CLLocationCoordinate2D] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        endText.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func transformAddress(_ sender: UIButton) {
        guard let start = startText.text else {return}
       if(self.i == 1)
       {
           self.startText.text = ""
           self.startText.resignFirstResponder()
           geocoder.geocodeAddressString(start) { (placemarks, error) in
               // Process Response
               self.processResponse(withPlacemarks: placemarks, error: error)
           }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NavView")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
       }
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
            self.locationText.text = "Unable to Find Location for Address"

              } else {
                  var location: CLLocation?

                  if let placemarks = placemarks, placemarks.count > 0 {
                      location = placemarks.first?.location
                  }

                  if let location = location {
                      let coordinate = location.coordinate
                    self.locationText.text! += "\(coordinate.latitude), \(coordinate.longitude) \n"
                    cords.append(coordinate)
                    print(cords)
                  } else {
                    self.locationText.text = "No Matching Location Found"
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
