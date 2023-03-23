//
//  MainView.swift
//  Porter
//
//  Created by Jinming Liang on 3/14/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var locationManager: LocationManager
    
    var body: some View {
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
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(locationManager: LocationManager())
    }
}
