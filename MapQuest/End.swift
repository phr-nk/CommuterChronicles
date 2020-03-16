//
//  End.swift
//  CommuterChronicles
//
//  Created by phrank on 3/15/20.
//  Copyright © 2020 Frank Lenoci. All rights reserved.
//

import Foundation

class End {

  // MARK: - Properties
  let name: String
  var item: Item


  // MARK: - Initializers
  init(name: String, _item: Item) {
    self.name = name
    self.item = _item
  }
}
extension End {
  static let end = End(name:"Hurray! You did it!",_item: Item(name: "Super Rare Thing", cost: 10000))
}

