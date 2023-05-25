//
//  SettingsView.swift
//  Porter
//
//  Created by Jinming Liang on 3/16/23.
//

import SwiftUI


class PathStore: ObservableObject { @Published var path = NavigationPath() }

struct SettingsView: View {
    
    @State var showBuisnessForm = false
    @State private var path: [Int] = []
    
    
    var body: some View {
        
        NavigationStack(path: $path){
            VStack{
                NavigationLink("Connect a bank account", destination: OpenLinkButton()).buttonStyle(.bordered)
                Button("Start your business"){
                    path.append(1)
                }.navigationDestination(for: Int.self){ int in
                    FormView(path: $path, count: int)
                }
            }
           .navigationTitle("Settings")
        }
    }
}


struct FormView: View{
    @Binding var path: [Int]
    let count: Int

    
    var body: some View{
        if (count == 1) {
            BusinessFormView(path: $path, count: count)
        }
        else if (count == 2){
            AddressFormView(path: $path, count: count)
        }
        else if (count == 3){
            ServiceFormView(path: $path)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
