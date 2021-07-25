//
//  DriversScreen.swift
//  F1HistoryApp
//
//  Created by Dmitry Pavlov on 09.07.2021.
//

import SwiftUI
import Networking
import UIComponents


final class DriversListViewModel: ObservableObject {
    @Published private(set) var drivers: [Driver] = .init()
    @Published private(set) var isPageLoading = false
    
    private(set) var offset = 0
    
    private var showBy = 30
    private(set) var maxItems = -1
    
    func loadItems() {
        if isPageLoading {
            return
        }
        isPageLoading = true
        DriversAPI.driversGet(limit: "\(showBy)", offset: "\(offset)") { data, err in
            self.drivers.append(contentsOf: data?.mRData?.driverTable?.drivers ?? .init())
            self.maxItems = Int(data?.mRData?.total ?? "") ?? 0
            
            if self.offset + self.showBy > self.maxItems {
                self.offset = self.maxItems
            } else {
                self.offset += self.showBy
            }
            self.isPageLoading = false
        }
    }
}

struct DriversScreen: View {
    @ObservedObject var viewModel = DriversListViewModel()
    
    var body: some View {
        if viewModel.maxItems < 0 {
            ProgressView("loading...")
                .onAppear {
                    viewModel.loadItems()
                }
        } else {
            list
        }
    }
    
    
    @State private var selection: String? = nil
    
    var list: some View {
        List(viewModel.drivers, id: \.self) { item in
            DriverScreenCell(item: item)
                .environmentObject(viewModel)
        }
    }
}

struct DriverScreenCell: View {
    
    @EnvironmentObject var viewModel: DriversListViewModel
    var item: Driver
    
    
    var body: some View {
        VStack(alignment: .center, spacing: .none) {
            if let url = URL(string: item.url ?? "") {
                HStack {
                    NavPushButton(destination: LazyView(DriverInfoScreen(driver: item)), title: "Driver info") {
                        Text(item.driverName)
                    }
                    Divider()
                    ZStack {
                        NavPushButton(destination: LazyView(WebViewScreen(title: item.driverName, url: url)), title: "Wiki of \(item.driverName)") {
                            Image(systemName: "w.circle")
                        }.frame(width: 100)
                    }
                }
            } else {
                Text(item.driverName)
            }
            if viewModel.isPageLoading && viewModel.drivers.last == item {
                Divider()
                ProgressView("loading...")
            }
        }
        .onAppear() {
            if viewModel.drivers.last == item {
                viewModel.loadItems()
            }
        }
    }
}

struct DriversScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
