//
//  PhotoTestView.swift
//  Porter
//
//  Created by Jinming Liang on 4/18/23.
//

import SwiftUI
import PhotosUI

struct PhotoTestView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        PhotosPicker(selection: $selectedItems,
                     matching: .images) {
            Text("Choose Photos")
        }
    }
}

struct PhotoTestView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoTestView()
    }
}
