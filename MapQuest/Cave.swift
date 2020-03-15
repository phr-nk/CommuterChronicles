//
//  Cave.swift
//  CommuterChronicles
//
//  Created by phrank on 3/13/20.
//  Copyright © 2020 Frank Lenoci. All rights reserved.
//

import Foundation

class Cave {

  // MARK: - Properties
  let name: String
  var item: Item
  var visited: Bool

  // MARK: - Initializers
  init(name: String, _item: Item,_visit: Bool) {
    self.name = name
    self.item = _item
    self.visited = _visit
  }
}
extension Cave {
  static let Chrono = Cave(name:"Chrono Cave",_item: Item(name: "Shield", cost: 20),_visit: false)
}

