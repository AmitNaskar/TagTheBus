//
//  ContainerViewController.swift
//  TagTheBus
//
//  Created by Amit Naskar on 21/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ContainerViewController: UITabBarController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateStations()
    }
    
    
    private func populateStations() {
        guard let url = URL.urlForStationsAPI() else {
            return
        }
        
        let resource = Resource<StationResponse>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] stationResponse in
                if let nearstations = stationResponse.data?.nearstations {
                    if let listVC = self?.viewControllers?[0] as? StationListViewController {
                        listVC.stationListVM = StationListViewModel(nearstations)
                        listVC.updateStationListUI()
                    }
                    
                    if let mapVC = self?.viewControllers?[1] as? StationMapViewController {
                        mapVC.placeMarkListModel = PlaceMarkListViewModel(placeMarks: nearstations)
                    }
                    
                }
            }).disposed(by: disposeBag)
    }
}
