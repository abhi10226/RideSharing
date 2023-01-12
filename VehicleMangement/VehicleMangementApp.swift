//
//  VehicleMangementApp.swift
//  VehicleMangement
//
//  Created by IPS-153 on 11/11/22.
//

import SwiftUI

@main
struct VehicleMangementApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
