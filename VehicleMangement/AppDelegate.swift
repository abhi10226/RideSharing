//
//  AppDelegate.swift
//  VehicleMangement
//
//  Created by IPS-153 on 11/11/22.
//

import UIKit
/*
class AppDelegate: NSObject {

}*/
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
             print(urls[urls.count-1] as URL)
            return true
    }
}
