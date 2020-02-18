//
//  StationMapViewController.swift
//  TagTheBus
//
//  Created by Amit Naskar on 21/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import MapKit

class StationMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    var placeMarkListModel: PlaceMarkListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setMapViewRegion()
        addPlacemarkToMap()
    }
    
    func setMapViewRegion() {
        guard let center = placeMarkListModel?.placeMarks.first?.coordinate else {
            return
        }
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        
        mapView.setRegion(region, animated: true)
    }
    
    // this function is used to add the placemark on the map
    func addPlacemarkToMap() {
        
        guard mapView != nil else {
            return
        }
        
        placeMarkListModel?.placeMarks.forEach({ placeMark in
            DispatchQueue.main.async {
                self.mapView.addAnnotation(placeMark)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tittle = sender as? String {
            if let imageListVC = segue.destination as? ImageListViewController {
                imageListVC.title = tittle
            }
        }
    }
}

extension StationMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var mapAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MAPAnnotationView") as? MKMarkerAnnotationView
        
        if mapAnnotationView == nil {
            
            mapAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MapAnnotationView")
            mapAnnotationView?.canShowCallout = true
            mapAnnotationView?.markerTintColor = UIColor.green
        } else {
            mapAnnotationView?.annotation = annotation
        }
        mapAnnotationView?.canShowCallout = true
        mapAnnotationView?.rightCalloutAccessoryView = UIButton.init(type: UIButton.ButtonType.detailDisclosure)
        return mapAnnotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        guard let annotation = view.annotation else {
            return
        }
        
        if let title = annotation.title as? String {
            performSegue(withIdentifier: "ShowImageList", sender: title)
        }
    }
}
