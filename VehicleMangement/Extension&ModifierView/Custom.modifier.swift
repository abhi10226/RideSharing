//
//  Custom.modifier.swift
//  VehicleMangement
//
//  Created by IPS-153 on 18/11/22.
//
import SwiftUI
struct NavigationBarWithBackCancelButtonWidgitModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let title: String
    let color: Color
    let showHamburgerImage: Bool
    let action: () -> ()
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            HStack{
                Button {
                    if showHamburgerImage {
                        action()
                    }
                } label: {
                    
                    Image("ic_hamburger")
                       
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20, alignment: .leading)
                        
                    
                }
                .padding(.leading, 16)
                
                Spacer(minLength: 16)
                Text(title)
                    .foregroundColor(.navigationTextColor)
                    .bold()
                    .lineLimit(1)
                Spacer(minLength: 16)
                Button {
                    
                } label: {
                    
                    Image("")
                        
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30, alignment: .trailing)
                        
                    
                }
            }
            .padding(.vertical, 15)
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .navigationColor)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
  
    
}
struct NavigationBarWithCrossButtonWidgitModifier: ViewModifier {
    let color: Color
    let showCancelImage: Bool
    let action: () -> ()
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            HStack{
                Button {
                    if showCancelImage {
                        action()
                    }
                } label: {
                    
                    Image("ic_closebtn")
                       
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20, alignment: .leading)
                        
                }
                .padding(.leading, 16)

                Spacer()
            }
            .padding(.vertical, 15)
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .navigationColor)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
  
    
}
struct NavigationBarWithBackButtonWidgitModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let color: Color
    let title : String
    let showCancelImage: Bool
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            //Navigation bar
            HStack{
                Button {
                    if showCancelImage {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    
                    Image("ic_back")
                       
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30, alignment: .leading)
                        
                }
                .padding(.leading, 16)
                
                Spacer(minLength: 16)
                Text(title)
                    .foregroundColor(.navigationTextColor)
                    .bold()
                    .lineLimit(1)
                Spacer(minLength: 16)
                Button {
                    
                } label: {
                    
                    Image("")
                        
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30, alignment: .trailing)
                        
                    
                }
            }
            .padding(.vertical, 15)
            .background(color)
            //view
            content
        }
        .statusBarStyle(color: .navigationColor)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
  
    
}

extension View {
    func statusBarStyle(color: Color) -> some View {
        self.modifier(StatusBarStyleModifier(color: color))
    }
    
    func customNavigationWithHamburgerMenu(action: @escaping () -> ()) -> some View {
        self.modifier(
            NavigationBarWithBackCancelButtonWidgitModifier(title: "Rider List", color: .navigationColor, showHamburgerImage: true, action: action)
        )
    }
    
    func custumNavigationWithCloseButton(action: @escaping () -> ()) -> some View {
        self.modifier(
            NavigationBarWithCrossButtonWidgitModifier(color: .bagGroundColor, showCancelImage: true, action: action)
        )
    }
    func custumNavigationWithBackButton() -> some View {
        self.modifier(
            NavigationBarWithBackButtonWidgitModifier(color: .navigationColor, title: "Add Driver", showCancelImage: true)
        )
    }
    func custumNavigationWithBackButtonAndTitle(title:String) -> some View {
        self.modifier(
            NavigationBarWithBackButtonWidgitModifier(color: .navigationColor, title: title, showCancelImage: true)
        )
    }
}

struct StatusBarStyleModifier: ViewModifier {
    let color: Color
    let statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    func body(content: Content) -> some View {
        VStack(spacing: 0){
            color
                .frame(width: UIScreen.main.bounds.width, height: statusBarHeight)
            
            content
        }
        .edgesIgnoringSafeArea(.top)
    }
}
