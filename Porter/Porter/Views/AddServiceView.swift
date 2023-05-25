//
//  AddServiceView.swift
//  Porter
//
//  Created by Jinming Liang on 4/5/23.
//

import SwiftUI


struct ServiceOffering: Identifiable{
    
    let id: UUID
    var name: String
    var description: String
    var price: Int
    
    init(id: UUID = UUID(),  name: String, description: String, price: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
    }
}

struct AddServiceView: View {
    
    @Binding var services: [ServiceOffering]
    @Binding var addNewService: Bool
    
    @State var name = ""
    @State var description = ""
    @State var price = ""
    
    func submit(){
        let newService = ServiceOffering(name: self.name, description: self.description, price: Int(self.price)! * 100)
        services.append(newService)
        addNewService = false
    }
    
    
    
    var body: some View {
        VStack{
            Form{
                TextField("Name of Service", text: $name)
                TextField("Description", text: $description)
                TextField("Price", text: $price).keyboardType(.numberPad)
                PhotoTestView()
            }
            Button(action: {submit()}, label: {Text("Submit")})
        }
    }
}

struct AddServiceView_Previews: PreviewProvider {
    static var previews: some View {
        Text("nah")
    }
}
