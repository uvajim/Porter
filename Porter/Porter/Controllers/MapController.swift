//
//  MapController.swift
//  Porter
//
//  Created by Jinming Liang on 3/16/23.
//

import Foundation
import MapKit

class PorterMapAnnotation: NSObject, MKAnnotation {
    

    @objc dynamic var coordinate : CLLocationCoordinate2D
    
    var title: String?
    
    var subtitle: String?
    
    
    init(coordindate: CLLocationCoordinate2D, title: String?, subtitle: String?){
        self.coordinate = coordindate
        self.title = title
        self.subtitle = subtitle
    }
}
