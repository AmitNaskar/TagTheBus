//
//  StationViewModel.swift
//  TagTheBus
//
//  Created by Amit Naskar on 21/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import RxSwift
import RxCocoa

struct StationListViewModel {
    let stationsVM: [StationViewModel]
}

extension StationListViewModel {
    
    init(_ stations: [Station]) {
        self.stationsVM = stations.compactMap(StationViewModel.init)
    }
}

extension StationListViewModel {
    
    func stationAt(_ index: Int) -> StationViewModel {
        return self.stationsVM[index]
    }
}

struct StationViewModel {
    
    let station: Station
    
    init(_ station: Station) {
        self.station = station
    }
}

extension StationViewModel {
    
    var id: Observable<String> {
        return Observable<String>.just(station.id ?? "")
    }
    
    var street_name: Observable<String> {
        return Observable<String>.just(station.street_name ?? "")
    }
    
    var utm_x: Observable<String> {
        return Observable<String>.just(station.utm_x ?? "")
    }
    
    var utm_y: Observable<String> {
        return Observable<String>.just(station.utm_y ?? "")
    }
    
    var lat: Observable<String> {
        return Observable<String>.just(station.lat ?? "")
    }
    
    var lon: Observable<String> {
        return Observable<String>.just(station.lon ?? "")
    }
    
    var furniture: Observable<String> {
        return Observable<String>.just(station.furniture ?? "")
    }
    
    var buses: Observable<String> {
        return Observable<String>.just(station.buses ?? "")
    }
    
    var distance: Observable<String> {
        return Observable<String>.just(station.distance ?? "")
    }
}
