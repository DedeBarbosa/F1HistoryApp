//
//  MainScreen.swift
//  OtusApp
//
//  Created by Dmitry Pavlov on 27.06.2021.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack{
            Text("F1 History App").font(.headline)
            Spacer()
            Button("Seasons") {
                router.tabSelection = 1
            }.foregroundColor(.black)
            Spacer()
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        MainScreen()
    }
}
