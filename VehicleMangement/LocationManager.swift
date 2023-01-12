//
//  LocationManager.swift
//  VehicleMangement
//
//  Created by IPS-153 on 15/11/22.
//

import Foundation
import CoreLocation
import Combine
import MapKit
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 42.0422448, longitude: -102.0079053),
           span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
       )
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }



    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location.coordinate
        self.region = MKCoordinateRegion(
                       center: location.coordinate,
                       span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                   )
        print(#function, location)
    }
    
}

