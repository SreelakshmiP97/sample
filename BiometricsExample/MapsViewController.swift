//
//  MapsViewController.swift
//  BiometricsExample
//
//  Created by Deepak on 13/12/21.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.requestLocation()
        }else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0), zoom: 8, bearing: 0, viewingAngle: 0)
        let marker = GMSMarker()
        marker.title = "hi"
        marker.snippet = "i'm here"
        marker.map = mapView
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
         return
        case .authorizedWhenInUse:
        return
        case .denied:
        return
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
        locationManager.requestWhenInUseAuthorization()
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
