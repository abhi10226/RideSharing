//
//  AddRiderView.swift
//  VehicleMangement
//
//  Created by IPS-153 on 12/11/22.
//

import SwiftUI
import AlertToast
struct AddRiderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var txtUserName:String = ""
    @State var naviToListOfRiderView: Bool = false
    @ObservedObject var viewModel = FormModel()
    @State var showToast: Bool = false
    @State var errorMessage: String = ""
    var body: some View {

        VStack(alignment: .center, spacing: 40) {
            
            VStack{
                VStack( spacing: 10){
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Enter Name")
                            .font(.callout)
                        TextField("Enter a userName..", text: $viewModel.txtName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Enter Contact Number")
                            .font(.callout)
                        TextField("Enter a Contact Number..", text: $viewModel.txtContact)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Enter Vehicle Type")
                            .font(.callout)
                        TextField("Enter a Vehicle Type..", text: $viewModel.txtVehicleType)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack(spacing: 10) {
                        VStack(alignment: .leading,spacing: 5) {
                            Text("Enter Source Latitude and longitude")
                                .font(.callout)
                            HStack(spacing: 10) {
                                TextField("Enter a Source Latitude..", text: $viewModel.txtSourceLat)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                TextField("Enter a Source Langitude..", text: $viewModel.txtSourceLon)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                            }
                        }
                    }
                    HStack(spacing: 10) {
                        VStack(alignment: .leading,spacing: 5) {
                            Text("Enter Destination Latitude and longitude")
                                .font(.callout)
                            HStack(spacing: 10) {
                                TextField("Enter a Destination Latitude..", text: $viewModel.txtDestinationLat)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                TextField("Enter a Destination Langitude..", text: $viewModel.txtDestinationLon)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                            }
                        }
                    }
                }
                
            }.padding(.horizontal,30)
                .padding(.top,50)
                Button("Add Rider") {
                    let valid = checkValidtion()
                    if valid.isvalid {
                        addItem()
                        self.mode.wrappedValue.dismiss() 
                    }else{
                        showToast = true
                        errorMessage = valid.errorMessage
                    }
                    
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)
                .background(Color.navigationColor)
                .cornerRadius(15)
               
           Spacer()
        }
        .background(Color.bagGroundColor)
        .custumNavigationWithBackButton()
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .regular, title: errorMessage)
        }
        
    }
    func checkValidtion() -> (isvalid:Bool,errorMessage:String) {
        var result = (isvalid:true,errorMessage:"")
        if String.validate(value: viewModel.txtName) {
            result.isvalid = false
            result.errorMessage = "Please Enter Name."
            return result
        }else if String.validate(value: viewModel.txtContact) {
            result.isvalid = false
            result.errorMessage = "Please Enter Your Contact Number."
            return result
        }else if String.validate(value: viewModel.txtVehicleType) {
            result.isvalid = false
            result.errorMessage = "Please Enter Vehicle Type."
            return result
        } else if String.validate(value: viewModel.txtSourceLat) {
            result.isvalid = false
            result.errorMessage = "Please Enter Source Latutude."
            return result
        }else if String.validate(value: viewModel.txtSourceLon) {
            result.isvalid = false
            result.errorMessage = "Please Enter Source Longitude."
            return result
        } else if String.validate(value: viewModel.txtDestinationLat) {
            result.isvalid = false
            result.errorMessage = "Please Enter Destination Latutude."
            return result
        }else if String.validate(value: viewModel.txtDestinationLon) {
            result.isvalid = false
            result.errorMessage = "Please Enter Destination Longitude."
            return result
        }
        return result
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = viewModel.txtName
            newItem.contact = viewModel.txtContact
            newItem.vehicleType = viewModel.txtVehicleType
            newItem.souceLat = viewModel.txtSourceLat
            newItem.souceLon = viewModel.txtSourceLon
            newItem.destinationLat = viewModel.txtDestinationLat
            newItem.destinationLog = viewModel.txtDestinationLon
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



struct AddRiderView_Previews: PreviewProvider {
    static var previews: some View {
        AddRiderView()
    }
}

extension String {
    static func validate(value:String?) -> Bool {
        var strNew = ""
        if value != nil{
            strNew = value!.trimWhiteSpace(newline: true)
        }
        if value == nil || strNew == "" || strNew.count == 0  {  return true  } else  {  return false  }
    }
    func trimWhiteSpace(newline: Bool = false) -> String {
        if newline {
            return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        } else {
            return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
        }
    }
}
