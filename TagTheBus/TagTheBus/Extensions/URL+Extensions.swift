//
//  URL+Extensions.swift
//  TagTheBus
//
//  Created by Amit Naskar on 21/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation

extension URL {
    
    static func urlForStationsAPI() -> URL? {
        return URL(string: "http://barcelonaapi.marcpous.com/bus/nearstation/latlon/41.3985182/2.1917991/1.json")
    }
    
}
