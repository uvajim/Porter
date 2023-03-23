//
//  MapView.swift
//  Porter
//
//  Created by Jinming Liang on 3/14/23.
//

import SwiftUI
import UIKit
import CoreLocation
import MapKit


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var region = MKCoordinateRegion()
        private let manager = CLLocationManager()
        override init() {
            super.init()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            locations.last.map {
                let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                region = MKCoordinateRegion(center: center, span: span)
            }
        }
}

struct MapView: View {
    
    
    @StateObject var locationManager : LocationManager
    
    @State private var showList = false
    
    var body: some View {
            NavigationStack{
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true).ignoresSafeArea()
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading, content: {
                            Button(action: {showList.toggle()}, label: {Image(systemName: "person.3.fill")})
                                .sheet(isPresented: $showList){
                                    ListView(showList: $showList)
                                }
                                
                        })
                    }
                
                
            }
            
    }
        
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationManager: LocationManager())
    }
}
