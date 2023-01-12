//
//  ListOfRiderView.swift
//  VehicleMangement
//
//  Created by IPS-153 on 12/11/22.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct ListOfRiderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var locationManger = LocationManager()
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Item>
    var body: some View {
        var arrItem: [arrItemListModel] = []
      
        if let lat = locationManger.lastLocation?.latitude,let lon = locationManger.lastLocation?.longitude {
            let coordinate2 = CLLocation(latitude: lat, longitude: lon)
            for item in items {
                let lat = (item.souceLat! as NSString).doubleValue
                let lon = (item.souceLon! as NSString).doubleValue
                let coordinate1 = CLLocation(latitude: lat, longitude: lon)
                let distance = coordinate1.distance(from: coordinate2)
                print(distance)
                arrItem.append(arrItemListModel(itemName: item.name!, distance: (distance/1000), sourceLatitude: item.souceLat!, sourceLongitude: item.souceLon!,vehicleType: item.vehicleType!,destinationlatitude: item.destinationLat!,destinationLongitude: item.destinationLog!,contactNumber: item.contact!))
   
            }
        }
        
        return ZStack {
            VStack {
                VStack {
                    Map(coordinateRegion: $locationManger.region, showsUserLocation: true,annotationItems: arrItem){ point in
                        MapAnnotation(coordinate: point.sourceCordinate2D) {
                            Image("ic_mapAnnotation")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(point.itemName ?? "")
                                .foregroundColor(.navigationColor)
                                .bold()
                            
                        }
                    }
                        .frame(height: UIScreen.main.bounds.height/2.5)
                }.cornerRadius(30)
                    .padding(30)
                    .shadow(radius: 6, x: 0, y: 2)
                VStack(alignment: .leading) {
                    let arrOfItem: [arrItemListModel] = arrItem.sorted(by: {$0.distance < $1.distance})
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(arrOfItem,id: \.itemName) { item in
                                if let item = item {
                                    RiderViewCell(item: item)
                                        .shadow(radius: 6, x: 0, y: 2)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        Spacer()
                    }
                    .padding(.horizontal,20)
                    .padding(.top,20)
                    .padding(.bottom,60)
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.navigationColor)
                .cornerRadius(20)
                .padding(.bottom,-20)
            }
            
            .background(Color("bgColor"))
        }.onAppear {
            print("userLongitude \(locationManger.lastLocation?.latitude)")
            print("userLongitude \(locationManger.lastLocation?.longitude)")
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



//struct ListOfRiderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListOfRiderView()
//    }
//}
