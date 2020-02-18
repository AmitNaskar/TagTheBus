//
//  Station.swift
//  TagTheBus
//
//  Created by Amit Naskar on 21/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation

struct StationResponse: Decodable {
     let data : StationJson?
}

struct StationJson: Decodable {
    let transport : String?
    let nearstations: [Station]
}

struct Station: Decodable {
    let id: String?
    let street_name: String?
    let utm_x: String?
    let utm_y: String?
    let lat: String?
    let lon: String?
    let furniture: String?
    let buses: String?
    let distance: String?
    
}
