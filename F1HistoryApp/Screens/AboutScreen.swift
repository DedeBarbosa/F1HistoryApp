//
//  AboutScreen.swift
//  OtusApp
//
//  Created by Dmitry Pavlov on 27.06.2021.
//

import SwiftUI

struct AboutScreen: View {
    
    @State var isModal: Bool = false
    
    var body: some View {
        Button("Open Modal") {
            isModal = true
        }.sheet(isPresented: $isModal) {
            someModal()
        }
        Spacer()
    }
}

struct someModal: View {
    var body: some View {
        Text("Hei! I should be modal")
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
