//
//  MainView.swift
//  Porter
//
//  Created by Jinming Liang on 3/14/23.
//

import SwiftUI
import FirebaseAuth

func checkUser()->Bool{
    if Auth.auth().currentUser != nil{
        return false
    }
    return true
}

struct MainView: View {
    
    @StateObject var locationManager: LocationManager
    @State var showLogIn = checkUser()
    
    var body: some View {
        //replace the false below with a variable to check if a user is signed in or not
        
        
            TabView{
                MapView(locationManager: locationManager)
                    .tabItem{
                        Label("Explore", systemImage: "map")
                    }
                PaymentView().tabItem{
                    Label("POS", systemImage: "dollarsign.circle")
                }
                CartView()
                    .tabItem{
                        Label("Cart", systemImage: "cart")
                    }
                SettingsView()
                    .tabItem{
                        Label("Settings", systemImage: "gear")
                    }
                
            }.fullScreenCover(isPresented: $showLogIn, content: {LoginView(showLogIn: $showLogIn)})
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(locationManager: LocationManager())
    }
}
