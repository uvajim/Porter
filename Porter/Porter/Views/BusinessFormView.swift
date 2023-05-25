//
//  BusinessFormView.swift
//  Porter
//
//  Created by Jinming Liang on 4/4/23.
//

import SwiftUI
import FirebaseAuth

struct BusinessFormView: View {
    @State var name = ""
    @State var businessType = "Online"
    let buisnessTypes = ["Online", "Physical Store", "Mobile"]
    @State var businessCategorie = ""
    @State var phone = ""
    
    @Binding var path: [Int]
    let count: Int
    
    func submit(){
        let userObj: [String: Any] = [
            "uid": Auth.auth().currentUser?.uid,
            "businessType": self.businessType,
            "businessCatergory": self.businessCategorie,
            "phone": self.phone,
            "email": Auth.auth().currentUser?.email
        ]
        //POST TO DATABASE
        if businessType == "Physical Store"{
            path.append(count + 1)
        }
        else{
            path.append(count + 2)
        }
        
    }
    
    func sendBusinessFormData() async throws{
        
    }
    
    var body: some View {
            VStack{
                Group{
                    
                    TextField("Name of your Buisness", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    TextField("What category would best describe your business?", text: $businessCategorie).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    HStack{
                        Text("Which of these options best describes your business?")
                        Picker("Which of these options best describes your business", selection: $businessType) {
                            ForEach(buisnessTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }.padding()
                    TextField("At what phone number can customers reach you?", text: $phone).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.phonePad).padding()
                }.padding()
                Button(action: {submit()}, label: {Text("Continue")})
            }.navigationTitle("About You")
        
    }
}

struct BusinessFormView_Previews: PreviewProvider {
    static var previews: some View {
        Text("hello")
    }
}
