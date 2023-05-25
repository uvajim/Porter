//
//  ServiceFormView.swift
//  Porter
//
//  Created by Jinming Liang on 4/5/23.
//

import SwiftUI

struct ServiceFormView: View {
    
    @State var services: [ServiceOffering] = []
    
    @Binding var path: [Int]
    
    @State var addNewService = false
    
    func postInfo() async throws{
        //creates the service obj to append to the data base
        var services_final : [[String: Any]] = []
        //iterates through all the services to create a dictionary of all the info about the services they need
        //TODO: MAKE THIS ASYNCRONOUS
            for  service in services{
                    services_final.append(
                        ["name": service.name,
                         "description": service.description,
                         "price": service.price])
        }
        
        //post the info
    }
    
    var body: some View {
        VStack{
            List{
                    ForEach(services){ service in
                        NavigationLink(service.name, destination: {AddServiceView(services: $services, addNewService: $addNewService, name: service.name, description: service.description, price: String(service.price / 100))})
                        }
            }.navigationTitle("Services")
                .toolbar {
                    Button(action: {addNewService = true}) {
                        Image(systemName: "plus")
                    }.fullScreenCover(isPresented: $addNewService, content: {AddServiceView(services: $services, addNewService: $addNewService)})
                }
            Button(action: {path = []
                Task{
                    try await postInfo()
                }
                           
            },
            label: {Text("Submit")})
        }
       
    }
}

struct ServiceFormView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ugh")
    }
}
