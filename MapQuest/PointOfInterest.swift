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

import Foundation
import CoreLocation
import MapKit
import UIKit

class PointOfInterest: NSObject  {


  var location: CLLocation
  // MARK: - Properties
  let name: String
  let isRegenPoint: Bool
  let encounter: Encounter?
  var image: UIImage

  // MARK: - Initializers
  init(name: String, location: CLLocation, isRegenPoint: Bool, encounter: Encounter? = nil,image: UIImage) {
    self.name = name
    self.location = location
    self.isRegenPoint = isRegenPoint
    self.encounter = encounter
    self.image = image
  }
}


extension PointOfInterest {
  static let depaulLib = PointOfInterest(name: "The Bone Zone", location: CLLocation(latitude: 41.925064, longitude: -87.655382), isRegenPoint: false, encounter: Store.AppleStore,image:#imageLiteral(resourceName: "storesmall"))
  static let LBLZ = PointOfInterest(name: "Monster Muck", location: CLLocation(latitude: 41.910391, longitude: -87.672791), isRegenPoint: false, encounter: Monster.Goblin,image:#imageLiteral(resourceName: "monster"))
    static let SAC = PointOfInterest(name: "Monster Muck", location: CLLocation(latitude: 41.924184, longitude: -87.655362), isRegenPoint: false, encounter: Monster.Goblin,image:#imageLiteral(resourceName: "monster"))
  
  
  
}
