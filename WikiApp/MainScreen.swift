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
        Button("Go To List") {
            router.tabSelection = 1
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        MainScreen()
    }
}
