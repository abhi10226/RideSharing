//
//  DriverDetail.swift
//  VehicleMangement
//
//  Created by IPS-153 on 21/11/22.
//

import SwiftUI
import UIKit
import MapKit
struct DriverDetail: View {
    @State private var directions: [String] = []
    @State private var showDirections = false
    var item: arrItemListModel
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Driver Name:- \(item.itemName)")
                    .foregroundColor(.textColor)
                    .font(.custom("", size: 24))
                    .bold()
                VStack {
                    
                    MapView(directions: $directions,p1: item.sourceCordinate2D,p2: item.destCordinate2D)
                        .frame(height: UIScreen.main.bounds.height/2.5)
                }.cornerRadius(30)
                    
                    .shadow(radius: 6, x: 0, y: 2)
            }
            .padding(30)
            Spacer()
            VStack(spacing: 10) {
              
                Button(action: {
                    self.showDirections.toggle()
                }, label: {
                    Text("Show directions")
                })
                    .disabled(directions.isEmpty)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)
                    .background(Color.navigationColor)
                    .cornerRadius(15)
                
                Button(action: {
                    print("Book Your Ride")
                }, label: {
                    Text("Book Your Ride")
                })
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)
                    .background(Color.navigationColor)
                    .cornerRadius(15)
            }
        }.custumNavigationWithBackButtonAndTitle(title: "Book Your Ride")
            .background(Color.bagGroundColor)
        .sheet(isPresented: $showDirections, content: {
            VStack(spacing: 0) {
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Divider().background(Color(UIColor.systemBlue))
                
                List(0..<self.directions.count, id: \.self) { i in
                    Text(self.directions[i]).padding()
                }
            }
        })
    }
    
}

struct MapView: UIViewRepresentable {

  typealias UIViewType = MKMapView

  @Binding var directions: [String]
    var p1: CLLocationCoordinate2D
    var p2: CLLocationCoordinate2D

  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator()
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator

    let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.0422448, longitude: -102.0079053),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    mapView.setRegion(region, animated: true)

    let p1 = MKPlacemark(coordinate: p1)
    let p2 = MKPlacemark(coordinate: p2)

    let request = MKDirections.Request()
      
    request.source = MKMapItem(placemark: p1)
    request.destination = MKMapItem(placemark: p2)
      request.transportType = .walking

    let directions = MKDirections(request: request)
    directions.calculate { response, error in
      guard let route = response?.routes.first else { return }
        let source = MKPointAnnotation()
        source.title = ""
        source.coordinate = CLLocationCoordinate2D(latitude: (p1.location?.coordinate.latitude)!, longitude: (p1.location?.coordinate.longitude)!)
       
        let dest = MKPointAnnotation()
        dest.title = ""
        dest.coordinate = CLLocationCoordinate2D(latitude: (p2.location?.coordinate.latitude)!, longitude: (p2.location?.coordinate.longitude)!)
        
      mapView.addAnnotations([source, dest])
      mapView.addOverlay(route.polyline)
      mapView.setVisibleMapRect(
        route.polyline.boundingMapRect,
        edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
        animated: true)
      self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
    }
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor(named: "NavigationColor")
            renderer.lineWidth = 5
            return renderer
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
        {
            if !(annotation is MKPointAnnotation) {
                return nil
            }
            
            let annotationIdentifier = "AnnotationIdentifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView!.canShowCallout = true
            }
            else {
                annotationView!.annotation = annotation
            }
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            let pinImage = UIImage(named: "ic_mapAnnotation")
            imageView.image = pinImage
            imageView.backgroundColor = .clear
            annotationView?.addSubview(imageView)
            annotationView?.backgroundColor = .clear
            return annotationView
        }
    }
}

//struct DriverDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        DriverDetail()
//    }
//}
