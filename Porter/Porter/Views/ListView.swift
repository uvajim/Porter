//
//  ListView.swift
//  Porter
//
//  Created by Jinming Liang on 3/14/23.
//

import SwiftUI

struct ListView: View {
    
    @Binding var showList: Bool
    
    
    let porters : [Porters] = [.init(name: "Jimmy", profession: "Tutor"),
                               .init(name: "Daniel", profession: "Babysitter"),
                               .init(name: "KISS", profession: "Band"),
                               .init(name: "Harvey", profession: "Clown"),]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(porters, id:\.name) { porter in
                    NavigationLink(value: porter.name){
                        Text(porter.name)
                    }}
                
            }
            .navigationTitle("Porters")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {showList.toggle()}, label: {Text("<-").font(.system(size:32))})
                })
            }
        }
    }
}

struct Porters: Hashable {
    let name: String
    let profession: String
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(showList: .constant(true))
    }
}
