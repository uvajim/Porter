//
//  FormNavigationView.swift
//  Porter
//
//  Created by Jinming Liang on 4/5/23.
//

import SwiftUI

struct FormNavigationView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack{
            NavigationLink("Business Form", destination: {BusinessFormView()}).navigationTitle("Boom")
        }
    }
}

struct FormNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        FormNavigationView()
    }
}
