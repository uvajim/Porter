//
//  PorterApp.swift
//  Porter
//
//  Created by Jinming Liang on 3/14/23.
//

import SwiftUI
import Foundation
import UIKit
import StripeTerminal
import FirebaseCore
import FirebaseAuth


@main
struct PorterApp: App {
    
    @StateObject var locationManager = LocationManager()
    
    
    init(){
        Terminal.setTokenProvider(APIClient.shared)
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView(locationManager: locationManager)
        }
    }
    
}

