//
//  Route.swift
//  CommuterChronicles
//
//  Created by phrank on 3/4/20.
//  Copyright © 2020 Frank Lenoci. All rights reserved.
//

import Foundation
import CoreLocation

class Route:NSObject
{
  var source: CLLocationCoordinate2D;
  var destination: CLLocationCoordinate2D;
  
  init(_source:CLLocationCoordinate2D,_destination:CLLocationCoordinate2D)
  {
    self.source = _source
    self.destination = _destination
  }
}
