//
//  DriverScreen.swift
//  F1HistoryApp
//
//  Created by Dmitry Pavlov on 09.07.2021.
//

import SwiftUI
import Networking
import UIComponents

struct DriverInfoScreen: View {
    var driver: Driver
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .trailing) {
                    Text("name:")
                    Text("nationality:")
                    Text("🔥 in:")
                }
                VStack(alignment: .leading) {
                    Text(driver.driverName)
                    Text(driver.emojiNationalityFlag() ?? (driver.nationality ?? "unknown"))
                    Text(driver.dateOfBirth ?? "unknown")
                }
            }
            Spacer()
            if let url = URL(string: driver.url ?? "") {
                ZStack {
                    NavPushButton(destination: LazyView(WebViewScreen(title: driver.driverName, url: url)), title: "Wiki of \(driver.driverName)") {
                        Image(systemName: "w.circle")
                            .font(.system(size: 40, weight: .bold))
                    }
                }.frame(height: 50)
            }
        }
    }
}

struct DriverScreen_Previews: PreviewProvider {
    static var previews: some View {
        DriverInfoScreen(driver: Driver())
    }
}
