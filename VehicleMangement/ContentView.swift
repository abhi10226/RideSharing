//
//  ContentView.swift
//  VehicleMangement
//
//  Created by IPS-153 on 11/11/22.
//

import SwiftUI
import CoreData
struct ContentView: View {
    @State var isNaviToRiderView: Bool = false
    @State var showMenu: Bool = false
    @StateObject var locationManger = LocationManager()
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width)
                            .transition(.move(edge: .leading))
                            .custumNavigationWithCloseButton {
                                showMenu.toggle()
                            }
                    }else{
                        ListOfRiderView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .customNavigationWithHamburgerMenu {
                                showMenu.toggle()
                            }

                    }
                }
                    .onAppear {
                        self.showMenu = false
                    }
            }
        }
        
    }

    
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
