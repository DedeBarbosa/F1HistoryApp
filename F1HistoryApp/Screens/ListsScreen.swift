//
//  ListsScreen.swift
//  F1HistoryApp
//
//  Created by Dmitry Pavlov on 20.07.2021.
//

import SwiftUI
import UIComponents


struct ListsScreen: View {
    var settings = ["Seasons", "Drivers"]
    @State var collectionViewChoice = 0
    
    var body: some View {
        VStack {
            Picker("Lists", selection: $collectionViewChoice) {
                ForEach(0 ..< settings.count) { index in
                    Text(self.settings[index])
                        .tag(index)
                }
                
            }.pickerStyle(SegmentedPickerStyle())
            Spacer()
            if collectionViewChoice == 0 {
                LazyView(NavigationView { SeasonsScreen().navigationBarHidden(true) })
            } else if collectionViewChoice == 1 {
                LazyView(NavControllerView(transition: .custom(.moveAndFade)){ DriversScreen()})
            }
        }
    }
}

struct ListsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListsScreen()
    }
}
