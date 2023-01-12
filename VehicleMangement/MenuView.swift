//
//  SideMenu.swift
//  VehicleMangement
//
//  Created by IPS-153 on 16/11/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image("ic_userName")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 83, height: 83, alignment: .leading)
                    .cornerRadius(20)
                VStack(alignment: .leading,spacing: 5) {
                    Text("Abhishek Mishra")
                        .font(.custom("", size: 18))
                        .bold()
                        .foregroundColor(.textColor)
                    Text("abc@gmail.com")
                        .font(.custom("", size: 10))
                        .foregroundColor(.textColor)
                }
            }
            .padding(.top,50)
            HStack(spacing: 10) {
                NavigationLink {
                    AddRiderView()
                } label: {
                    Image("ic_profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24)
                    Text("Add Driver")
                        .foregroundColor(Color.textColor)
                        .font(.custom("", size: 14))
                        .font(.headline)
                }
            }
            .padding(.top, 50)
            HStack(spacing: 10) {
                Image("ic_about")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                Text("About us")
                    .foregroundColor(Color.textColor)
                    .font(.custom("", size: 14))
                    .font(.headline)
            }
                .padding(.top, 30)
            HStack(spacing: 10) {
                Image("ic_notification")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                Text("Notification")
                    .foregroundColor(Color.textColor)
                    .font(.custom("", size: 14))
                    .font(.headline)
            }
                .padding(.top, 30)
            HStack(spacing: 10) {
                Image("ic_settings")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                Text("Setting")
                    .foregroundColor(Color.textColor)
                    .font(.custom("", size: 14))
                    .font(.headline)
            }
                .padding(.top, 30)
            HStack(spacing: 10) {
                Image("ic_logout")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                Text("Logout")
                    .foregroundColor(Color.textColor)
                    .font(.custom("", size: 14))
                    .font(.headline)
            }
                .padding(.top, 30)
           
            Spacer()
        }
        .padding(.horizontal,50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.bagGroundColor)
            .edgesIgnoringSafeArea(.all)
    }
}
