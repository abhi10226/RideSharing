//
//  FormModel.swift
//  VehicleMangement
//
//  Created by IPS-153 on 12/11/22.
//

import Foundation
import SwiftUI
class FormModel: ObservableObject{
    @Published var txtName:String = ""
    @Published var txtVehicleType:String = ""
    @Published var txtContact: String = ""
    @Published var txtSourceLat:String = ""
    @Published var txtSourceLon:String = ""
    @Published var txtDestinationLat:String = ""
    @Published var txtDestinationLon:String = ""
}
