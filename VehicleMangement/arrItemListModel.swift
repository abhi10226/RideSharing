//
//  arrItemList.swift
//  VehicleMangement
//
//  Created by IPS-153 on 15/11/22.
//

import Foundation
import CoreLocation

struct arrItemListModel: Hashable,Identifiable {
    var id = UUID()
    var itemName:String
    var distance:Double
    var sourceLatitude: String
    var sourceLongitude:String
    var vehicleType: String
    var destinationlatitude:String
    var destinationLongitude: String
    var contactNumber: String
    var sourceCordinate2D : CLLocationCoordinate2D {
        if let lat =  Double(sourceLatitude), let lon = Double(sourceLongitude) {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
    
    var destCordinate2D : CLLocationCoordinate2D {
        if let lat =  Double(destinationlatitude), let lon = Double(destinationLongitude) {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
}


