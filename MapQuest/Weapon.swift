//
//  Weapon.swift
//  CommuterChronicles
//
//  Created by phrank on 3/13/20.
//  Copyright © 2020 Frank Lenoci. All rights reserved.
//

import Foundation

class Weapon : Item {

  // MARK: - Properties
  let strength: Int

  // MARK: - Initializers
  init(name: String, cost: Int, strength: Int) {
    self.strength = strength
    super.init(name: name, cost: cost)
  }
}

extension Weapon {
  static let Sword6Plus = Weapon(name: "Sword 6+", cost: 50, strength: 6)
  static let Shield = Weapon(name: "Defence 5+", cost: 20, strength: 6)
}
