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

import UIKit
import CoreLocation

let ENCOUNTER_RADIUS: CLLocationDistance = 30 //meters

enum FightResult {
  case HeroWon, HeroLost, Tie
}

enum ItemResult {
  case Purchased, NotEnoughMoney
}

let GameStateNotification = Notification.Name("GameUpdated")

protocol GameDelegate: class {
  func encounteredMonster(monster: Monster)
  func encounteredNPC(npc: NPC)
  func enteredStore(store: Store)
  func enteredCave(cave: Cave) //added
  func encounteredEnd(end: End) //added
}

class Game {

  // MARK: - Properties
  static let shared = Game()
  var adventurer: Adventurer?
  var pointsOfInterest: [PointOfInterest] = []
  var lastPOI: PointOfInterest?
  var warps: [WarpZone] = []
  var reservoir: [CLLocationCoordinate2D] = []
  weak var delegate: GameDelegate?

  // MARK: - Initializers
  init() {
    adventurer = Adventurer(name: "Hero", hitPoints: 10, strength: 10,image: userimage ?? UIImage(named: "wizard")!)
    setupPOIs()
    setupWarps()
  }

  private func setupPOIs() {
    pointsOfInterest = [  PointOfInterest(name: "A local shop", location: CLLocation(latitude: 41.910029, longitude: -87.674211), isRegenPoint: false, encounter: Store.AppleStore,image:#imageLiteral(resourceName: "shopmap"),visited: false),
                          PointOfInterest(name: "Monster Muck", location: CLLocation(latitude: 41.924184, longitude: -87.655362), isRegenPoint: false, encounter: Monster.Cyclops,image:#imageLiteral(resourceName: "monster"),visited: false),
                          PointOfInterest(name: "Chrono Cave", location: CLLocation(latitude: 41.910848, longitude: -87.675880), isRegenPoint: true, encounter: Cave.Chrono,image:#imageLiteral(resourceName: "CAVEMAP"),visited: false),]
    
  }

  private func setupWarps() {
    warps = [WarpZone(latitude: 40.765158, longitude: -73.974774, color: #colorLiteral(red: 0.9882352941, green: 0.8, blue: 0.03921568627, alpha: 1)),
             WarpZone(latitude: 40.768712, longitude: -73.981590, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.768712, longitude: -73.981590, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.776219, longitude: -73.976247, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.776219, longitude: -73.976247, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.781987, longitude: -73.972020, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.781987, longitude: -73.972020, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.785253, longitude: -73.969638, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.785253, longitude: -73.969638, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.791605, longitude: -73.964853, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.791605, longitude: -73.964853, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.796089, longitude: -73.961463, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.796089, longitude: -73.961463, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.799988, longitude: -73.958480, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
             WarpZone(latitude: 40.799988, longitude: -73.958480, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.798493, longitude: -73.952622, color: #colorLiteral(red: 0.9333333333, green: 0.2078431373, blue: 0.1803921569, alpha: 1)),
             WarpZone(latitude: 40.755238, longitude: -73.987405, color: #colorLiteral(red: 0.7254901961, green: 0.2, blue: 0.6784313725, alpha: 1)),
             WarpZone(latitude: 40.754344, longitude: -73.987105, color: #colorLiteral(red: 0.9882352941, green: 0.8, blue: 0.03921568627, alpha: 1)),
             WarpZone(latitude: 40.865757, longitude: -73.927088, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
             WarpZone(latitude: 40.701789, longitude: -74.013004, color: #colorLiteral(red: 0.9333333333, green: 0.2078431373, blue: 0.1803921569, alpha: 1)),
             WarpZone(latitude: 41.924184, longitude: -87.655362,color:#colorLiteral(red: 0.9333333333, green: 0.2078431373, blue: 0.1803921569, alpha: 1))
    ]
  }

  
 
  func genRandomLat(lat: CLLocationDegrees, lat2: CLLocationDegrees) -> CLLocationDegrees
  {
    let randomLat = Double.random(in: lat ..< lat2)
    return randomLat
  }
  func genRandomLong(long:CLLocationDegrees, long2: CLLocationDegrees) -> CLLocationDegrees
  {
    let randomLong = Double.random(in: long ..< long2)
    return randomLong
  }
  func visitedLocation(location: CLLocation) {
    guard let currentPOI = poiAtLocation(location: location) else { return }

    if currentPOI.isRegenPoint {
      regenAdventurer()
    }

    switch currentPOI.encounter {
    case let npc as NPC:
      delegate?.encounteredNPC(npc: npc)
    case let monster as Monster:
      delegate?.encounteredMonster(monster: monster)
    case let store as Store:
      delegate?.enteredStore(store: store)
    case let cave as Cave:
      delegate?.enteredCave(cave: cave)
    case let end as End:
      delegate?.encounteredEnd(end: end)
    default:
      break
    }
  }

  func poiAtLocation(location: CLLocation) -> PointOfInterest? {
    for point in pointsOfInterest {
      let center = point.location
      let distance = abs(location.distance(from: center))
      if distance < ENCOUNTER_RADIUS {
        //debounce staying in the same spot for awhile
        if point != lastPOI  {
         lastPOI = point
         return point
       } else {
          return nil
       }
    }
    }
    lastPOI = nil
    return nil
  }

  func regenAdventurer() {
    guard let adventurer = adventurer else { return }

    adventurer.hitPoints = adventurer.maxHitPoints
    adventurer.isDefeated = false
  }

  func fight(monster: Monster) -> FightResult? {
    guard let adventurer = adventurer else { return nil }

    defer { NotificationCenter.default.post(name: GameStateNotification, object: self) }

    //give the hero a fighting chance
    monster.hitPoints -= adventurer.strength
    if monster.hitPoints <= 0 {
      adventurer.gold += monster.gold
      return .HeroWon
    }

    adventurer.hitPoints -= monster.strength
    if adventurer.hitPoints <= 0 {
      adventurer.isDefeated = true
      return .HeroLost
    }

    return .Tie
  }

  func purchaseItem(item: Item) -> ItemResult? {
    guard let adventurer = adventurer else { return nil }

    defer { NotificationCenter.default.post(name: GameStateNotification, object: self) }

    if adventurer.gold >= item.cost {
      adventurer.gold -= item.cost
      adventurer.inventory.append(item)
      return .Purchased
    } else {
      return .NotEnoughMoney
    }

  }
}

extension Game {

  func image(for monster: Monster) -> UIImage? {
    switch monster.name {
    case Monster.Cyclops.name:
      return UIImage(named: "goblin")
    case NPC.King.name:
      return UIImage(named: "king")
    case Monster.Ghost.name:
      return UIImage(named: "ghost")
    default:
      return nil
    }
  }

  func image(for store: Store) -> UIImage? {
    return UIImage(named: "store")
  }

  func image(for item: Item) -> UIImage? {
    switch item.name {
    case Weapon.Sword6Plus.name:
      return UIImage(named: "sword")
    case Weapon.Shield.name:
      return UIImage(named: "shield")
    default:
      return nil
    }
  }
}
