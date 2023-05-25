//
//  AddressFormView.swift
//  Porter
//
//  Created by Jinming Liang on 4/4/23.
//

import SwiftUI

struct AddressFormView: View {
    
    @State var address_1 = ""
    @State var address_2 = ""
    @State var zip_code = ""
    @State var state = ""
    @State var city = ""
    
    @Binding var path: [Int]
    let count: Int
    
    func submitAddress(){
        let address = [
            "address": self.address_1,
            "address_2": self.address_2,
            "city": self.city,
            "zip_code": self.zip_code,
            "state": self.state
        ]
        //POST to the server,
        path.append(count + 1)
    }
    
    var body: some View {
        VStack{
            TextField("Address", text: $address_1).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            TextField("Address 2", text: $address_2).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            TextField("Zip Code", text: $zip_code).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            TextField("City", text: $city).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            TextField("State", text: $state).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
        Button(action: {submitAddress()
            
        }, label: {Text("Submit")})
        }.navigationTitle("Add an Address")
            
    }
}

struct AddressFormView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder")
    }
}
