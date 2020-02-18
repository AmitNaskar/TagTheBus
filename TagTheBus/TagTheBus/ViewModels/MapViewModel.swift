//
//  MapViewModel.swift
//  TagTheBus
//
//  Created by Amit Naskar on 22/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel : NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title :String?
    init(station : Station) {
        let lat = Double(station.lat ?? "0")
        let long = Double(station.lon ?? "0")
        
        self.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)
        self.title = station.street_name ?? ""
    }
}

struct PlaceMarkListViewModel {
   let placeMarks: [MapViewModel]
    init(placeMarks: [Station]) {
        self.placeMarks = placeMarks.map({ station in
            MapViewModel.init(station: station)
        })
    }
}
