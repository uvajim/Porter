//
//  SettingsView.swift
//  Porter
//
//  Created by Jinming Liang on 3/16/23.
//

import SwiftUI

struct SettingsView: View {
    
    var linkController = PlaidController()
    
    init(){
        linkController.fetchLinkToken()
    }
    
    var body: some View {
        OpenLinkButton()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
