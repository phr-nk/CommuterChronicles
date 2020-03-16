/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */


// I have made many changes to this view controller and will note them when added

import UIKit
import MapKit

class MapViewController: UIViewController {

  //added
  //MARK: Route end points
  var routeStart:String?
  var routeEnd:String?
  //added
  var cordStart:CLLocationCoordinate2D?
  var cordEnd: CLLocationCoordinate2D?

  // MARK: - IBOutlets
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var heartsLabel: UILabel!



  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let request = MKDirections.Request() //added
    
    
      //added for lines 60 to 122
      let start = cords[0] //start coord
      let end = cords[1] //end coord
    
      
      let endPOI = PointOfInterest(name: "End Goal", location: CLLocation(latitude: cords[1].latitude, longitude: cords[1].longitude), isRegenPoint: true, encounter: End.end ,image:#imageLiteral(resourceName: "END"),visited: false)
    
    for _ in 0...1 //add ghosts
    {
      Game.shared.pointsOfInterest.append(PointOfInterest(name: "Monster", location: CLLocation(latitude: self.genRandomLat(lat:cords[0].latitude,lat2: cords[1].latitude), longitude: self.genRandomLong(long:cords[0].longitude,long2:cords[1].longitude)), isRegenPoint: false, encounter: Monster.Ghost ,image:#imageLiteral(resourceName: "ghost"),visited: false))
    }
    for _ in 0...2 //add cyclops
    {
      Game.shared.pointsOfInterest.append(PointOfInterest(name: "Monster", location: CLLocation(latitude: self.genRandomLat(lat:cords[0].latitude,lat2: cords[1].latitude), longitude: self.genRandomLong(long:cords[0].longitude,long2:cords[1].longitude)), isRegenPoint: false, encounter: Monster.Cyclops ,image:#imageLiteral(resourceName: "monster"),visited: false))
    }
    
      
      Game.shared.pointsOfInterest.append(endPOI)
      let sourcePlacemark = MKPlacemark(coordinate: start, addressDictionary: nil)
      let desPlacemark = MKPlacemark(coordinate: end,addressDictionary: nil)
      
      
      let sourceMap = MKMapItem(placemark: sourcePlacemark)
      let desMap = MKMapItem(placemark: desPlacemark)
      request.source = sourceMap
      request.destination = desMap
      request.requestsAlternateRoutes = true
      request.transportType = .walking
      
      let sourceAnn = MKPointAnnotation()
      
      if let location = sourcePlacemark.location
      {
        sourceAnn.coordinate = location.coordinate
      }
      
      let desAnn = MKPointAnnotation()
      
      if let location = desPlacemark.location
      {
        desAnn.coordinate = location.coordinate
      }
      
      self.mapView.showAnnotations([sourceAnn,desAnn], animated: true)
      
      let directions = MKDirections(request: request)
      
      
      // 8.
      directions.calculate {
                 (response, error) -> Void in
                 
                 guard let response = response else {
                     if let error = error {
                         print("Error: \(error)")
                     }
                     
                     return
                 }
                 
                 let route = response.routes[0]
        self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
      }

  
    
    mapView.addAnnotations(Game.shared.pointsOfInterest)


    mapView.showsUserLocation = true
    mapView.showsCompass = true
    mapView.setUserTrackingMode(.followWithHeading, animated: true)

  
    Game.shared.delegate = self

    NotificationCenter.default.addObserver(self, selector: #selector(gameUpdated(notification:)), name: GameStateNotification, object: nil)
    mapView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    renderGame()
  }


  func getCoordinate( forPlaceCalled name : String,
          completion: @escaping(CLLocation?) -> Void ) {
        let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(name) { placemarks, error in
                
                guard error == nil else {
                    print("*** Error in \(#function): \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("*** Error in \(#function): placemark is nil")
                    completion(nil)
                    return
                }
                
                guard let location = placemark.location else {
                    print("*** Error in \(#function): placemark is nil")
                    completion(nil)
                    return
                }

                completion(location)
            }
  }
  
 
  func genRandomLat(lat: CLLocationDegrees, lat2: CLLocationDegrees) -> CLLocationDegrees
  {
    let rand = Double.random(in: 0.00009...0.0009)
    let randInt = Int.random(in: 0...1)
    print(randInt)
    var finalCord: CLLocationDegrees?
    let latdiff = lat - lat2
    if latdiff < 0
    {
      if(randInt == 0)
      {
        finalCord = lat - rand
      }
      else
      {
           finalCord = lat + rand
      }
    }
    if latdiff > 0
    {
      if(randInt == 0)
      {
        finalCord = lat2 - rand
      }
      else
      {
           finalCord = lat2 + rand
      }
    }

    return finalCord!
  }
  func genRandomLong(long:CLLocationDegrees, long2: CLLocationDegrees) -> CLLocationDegrees
  {
       let rand = Double.random(in: 0.00008...0.005)
       let randInt = Int.random(in: 0...1)
       var finalCord: CLLocationDegrees?
       let longdiff = long - long2
       if longdiff < 0
       {
          if(randInt == 0)
              {
                finalCord = long - rand
              }
              else
              {
                   finalCord = long + rand
              }
       }
       if longdiff > 0
       {
          if(randInt == 0)
              {
                finalCord = long2 - rand
              }
              else
              {
                   finalCord = long2 + rand
              }
       }

       return finalCord!
  }
  @objc func gameUpdated(notification: Notification) {
    renderGame()
  }

  // MARK: - Navigation to Shop
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "shop",
      let shopController = segue.destination as? ShopViewController,
      let store = sender as? Store {
        shopController.shop = store
    }
   if segue.identifier == "cave",
      let caveController = segue.destination as? CaveViewController,
      let c = sender as? Cave {
        caveController.cave = c
    }
    }
}


// MARK: - MapView Delegate
extension MapViewController: MKMapViewDelegate {
  // Add mapview delegate code here
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    switch annotation {
      
    case let user as MKUserLocation:
      
      let view = mapView.dequeueReusableAnnotationView(withIdentifier: "user")
        ?? MKAnnotationView(annotation: user, reuseIdentifier: "user")
      
      view.image = userimage
      return view
      
      
    case let poi as PointOfInterest:
      let view = mapView.dequeueReusableAnnotationView(withIdentifier: POIAnnotationView.identifier)
      ?? POIAnnotationView(annotation: poi, reuseIdentifier: POIAnnotationView.identifier)
      view.annotation = poi
      
      return view
    default:
      return nil
    }
  }

}

// MARK: - Game UI
extension MapViewController {

  private func heartsString() -> String {
    guard let hp = Game.shared.adventurer?.hitPoints else { return "☠️" }

    let heartCount = hp / 2
    var string = ""
    for _ in 1 ... heartCount {
      string += "❤️"
    }
    return string
  }

  private func goldString() -> String {
    guard let gold = Game.shared.adventurer?.gold else { return "" }

    return "💰\(gold)"
  }

  fileprivate func renderGame() {
    heartsLabel.text = heartsString() + "\n" + goldString()
  }
}

// MARK: - Game Delegate
extension MapViewController: GameDelegate {

  func encounteredMonster(monster: Monster) {
    showFight(monster: monster)
  }

  func showFight(monster: Monster, subtitle: String = "Fight?") {
    let alert = AABlurAlertController()

    let finishedalert = AABlurAlertController()
    alert.addAction(action: AABlurAlertAction(title: "Run", style: AABlurActionStyle.cancel) { [unowned self] _ in
      self.showFight(monster: monster, subtitle: "I think you should really fight this.")
    })

    alert.addAction(action: AABlurAlertAction(title: "Fight", style: AABlurActionStyle.default) { [unowned self] _ in
      guard let result = Game.shared.fight(monster: monster) else { return }

      switch result {
      case .HeroLost:
        finishedalert.alertTitle.text = "You lost!"
        print("loss!")
      case .HeroWon:
        finishedalert.alertTitle.text = "You won! + 10 gold"
        print("win!")
      case .Tie:
        self.showFight(monster: monster, subtitle: "A good row, but you are both still in the fight!")
      }
    })

    alert.blurEffectStyle = .regular

    let image = monster.image
    alert.alertImage.image = image
    alert.alertTitle.text = "A wild \(monster.name) appeared!"
    alert.alertSubtitle.text = subtitle
    present(alert, animated: true) {}
    present(finishedalert,animated: true)
  }



  func enteredStore(store: Store) {
    let alert = AABlurAlertController()

    alert.addAction(action: AABlurAlertAction(title: "Back Out", style: AABlurActionStyle.cancel) {  _ in
      print("did not buy anything")
    })

    alert.addAction(action: AABlurAlertAction(title: "Take My 💰", style: AABlurActionStyle.default) { [unowned self] _ in
      self.performSegue(withIdentifier: "shop", sender: store)
    })

    alert.blurEffectStyle = .regular

    let image = UIImage(named: "store-1")
    alert.alertImage.image = image
    alert.alertTitle.text = store.name
    alert.alertSubtitle.text = "Shopping for accessories?"
    present(alert, animated: true)
  }
  func enteredCave(cave: Cave) {
    let alert = AABlurAlertController()

    alert.addAction(action: AABlurAlertAction(title: "Back Out", style: AABlurActionStyle.cancel) {  _ in
      print("did not buy anything")
    })

    alert.addAction(action: AABlurAlertAction(title: "Explore Cave", style: AABlurActionStyle.default) { [unowned self] _ in
      self.performSegue(withIdentifier: "cave", sender: cave)
    })

    alert.blurEffectStyle = .regular

    let image = UIImage(named: "cave-enterance")
    alert.alertImage.image = image
    alert.alertTitle.text = cave.name
    present(alert, animated: true)
  }
  func encounteredEnd(end: End) {
  
    let alert = AABlurAlertController()

    alert.addAction(action: AABlurAlertAction(title: "Back Out", style: AABlurActionStyle.cancel) {  _ in
    })


    alert.blurEffectStyle = .regular

    let image = UIImage(named: "goldbag")
    alert.alertImage.image = image
    alert.alertTitle.text = end.name
    present(alert, animated: true)
  }

  func addRoute() -> MKPolyline{
   
    let cord1 = self.cordStart!
    let cord2 = self.cordEnd!
    let coords = [cord1,cord2]
    let myPolyline = MKPolyline(coordinates: coords, count: coords.count)
      
    return myPolyline
  }
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
         renderer.strokeColor = UIColor.blue
         return renderer
  }

}

