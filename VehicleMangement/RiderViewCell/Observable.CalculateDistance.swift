//
//  Observable.CalculateDistance.swift
//  VehicleMangement
//
//  Created by IPS-153 on 16/11/22.
//

import SwiftUI
import CoreLocationUI
import CoreLocation
class CalculateDistance: ObservableObject {

    @Published var arrItem: [arrItemListModel] = []
    
    func calculateDistance(lat:CLLocationDegrees,lon:CLLocationDegrees, item : FetchedResults<Item>) {
        
        let coordinate2 = CLLocation(latitude: lat, longitude: lon)
        for item in item {
            let lat = (item.souceLat as! NSString).doubleValue
            let lon = (item.souceLon as! NSString).doubleValue
            let coordinate1 = CLLocation(latitude: lat, longitude: lon)
            let distance = coordinate1.distance(from: coordinate2)
            print(distance)
        //    arrItem.append(arrItemListModel(itemName: item.name!, distance: (distance/1000), sourceLatitude: item.souceLat!, sourceLongitude: item.souceLon!,vehicleType: item.vehicleType!,destinationlatitude: item.destinationLat!,destinationLongitude: item.destinationLog!))
        }
    }
}
