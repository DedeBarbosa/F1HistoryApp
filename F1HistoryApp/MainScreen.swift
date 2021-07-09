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
            Spacer()
            Button("Seasons") {
                router.listSelection = .seasons
                router.tabSelection = 1
            }.foregroundColor(.black)
            Spacer()
            Button("Drivers") {
                router.listSelection = .drivers
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
