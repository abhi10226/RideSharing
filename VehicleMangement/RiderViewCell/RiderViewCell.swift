//
//  RiderViewCell.swift
//  VehicleMangement
//
//  Created by IPS-153 on 14/11/22.
//

import SwiftUI
import CoreLocation
struct RiderViewCell: View {
    var item : arrItemListModel
    @State var cityName: String = ""
    var body: some View {
        let location = CLLocation(latitude: item.destCordinate2D.latitude, longitude: item.destCordinate2D.longitude)
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
           cityName = city
        }
        return ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading,spacing: 15) {
                HStack( spacing: 10) {
                    if item.vehicleType == "Bike" {
                        Image("Bike")
                            .resizable()
                            .cornerRadius(20)
                            .frame(width: 80, height: 80)
                    }else {
                        Image("Car")
                            .resizable()
                            .cornerRadius(20)
                            .frame(width: 80, height: 80)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(item.itemName)")
                            .font(.custom("", size: 18))
                            .bold()
                            .foregroundColor(.navigationColor)
                        Text("Contact no : \(item.contactNumber)")
                            .font(.custom("", size: 10))
                            .foregroundColor(.textColor)
                        Text("Destination : \(cityName)")
                            .font(.custom("", size: 10))
                            .foregroundColor(.textColor)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Text("Distance Form your Location")
                            .lineLimit(2)
                            .font(.custom("", size: 8))
                            .foregroundColor(.textColor)
                            .font(.caption)
                        Text("\(String(format: "%.2f", item.distance)) Km")
                            .font(.custom("", size: 20))
                            .bold()
                            .foregroundColor(.textColor)
                    }
                }
               
                HStack {
                    if item.vehicleType == "Bike" {
                        Text("Avaliable Seat: 1")
                            .font(.custom("", size: 14))
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.textColor)
                    }else{
                        Text("Avaliable Seat: 3")
                            .font(.custom("", size: 14))
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.textColor)
                    }
                    Spacer()
                    HStack {
                        NavigationLink {
                            DriverDetail(item: item)
                        } label: {
                            Image("ic_buttonArrow")
                                .resizable()
                                .scaledToFill()
                                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                                .background(Color.navigationColor)
                        }
                        .frame(width: 72, height: 35)
                        .cornerRadius(10)
                    }
                   

                    
                }
              
            }.padding(15)
                
           
        }.background(Color("bgColor"))
            .cornerRadius(10)
           
        
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.subLocality, $0?.first?.country, $1) }
    }
}
//struct RiderViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RiderViewCell()
//    }
//}
