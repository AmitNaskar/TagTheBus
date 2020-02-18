//
//  StationListViewController.swift
//  TagTheBus
//
//  Created by Amit Naskar on 21/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StationListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var stationListVM: StationListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateStationListUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tittle = sender as? String {
            if let imageListVC = segue.destination as? ImageListViewController {
                imageListVC.title = tittle
            }
        }
    }
}

extension StationListViewController : UITableViewDelegate, UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationListVM == nil ? 0: self.stationListVM?.stationsVM.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath) as? StationTableViewCell else {
            fatalError("StationTableViewCell is not found")
        }
        
        let stationVM = self.stationListVM?.stationAt(indexPath.row)
        
        if let textLabel = cell.textLabel {
            stationVM?.street_name.asDriver(onErrorJustReturn: "")
                .drive(textLabel.rx.text)
                .disposed(by: disposeBag)
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationVM = self.stationListVM?.stationAt(indexPath.row)
        performSegue(withIdentifier: "ShowImageList", sender: stationVM?.station.street_name ?? "")
    }
}
