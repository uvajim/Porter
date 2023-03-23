//
//  ProfileView.swift
//  Porter
//
//  Created by Jinming Liang on 3/14/23.
//

import SwiftUI

struct ProfileView: View {
    let name: String
    let profession: String
    
    var body: some View {
        VStack{
            Text(name)
            Text(profession)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "Jimmy", profession: "flute player")
    }
}
