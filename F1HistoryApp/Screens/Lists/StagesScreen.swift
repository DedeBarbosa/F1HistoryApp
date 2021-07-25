//
//  SeasonScreen.swift
//  F1HistoryApp
//
//  Created by Dmitry Pavlov on 09.07.2021.
//

import SwiftUI
import Networking
import UIComponents
import MapKit

final class StagesScreenViewModel: ObservableObject {
    @Published var races: [Race] = .init()
    @Published private(set) var isPageLoading = false
    
    private(set) var offset = 0
    
    private var showBy = 0
    private(set) var maxItems = -1
    private var year: String = ""
    
    init(with year: String) {
        self.year = year
    }
    
    func loadItems() {
        if isPageLoading || races.count == maxItems{
            return
        }
        isPageLoading = true
        SeasonStagesAPI.getSeasonByYear(year: year) { data, err in
            self.races.append(contentsOf: data?.mRData?.raceTable?.races ?? .init())
            self.maxItems = Int(data?.mRData?.total ?? "") ?? 0
            self.showBy = data?.mRData?.raceTable?.races?.count ?? 0
            if self.offset + self.showBy > self.maxItems {
                self.offset = self.maxItems
            } else {
                self.offset += self.showBy
            }
            self.isPageLoading = false
        }
    }
    
}

struct StagesScreen: View {
    @ObservedObject var viewModel: StagesScreenViewModel
    
    var body: some View {
        if viewModel.offset == viewModel.maxItems {
            list
        } else {
            ProgressView("loading...")
                .onAppear {
                    viewModel.loadItems()
                }
        }
    }
    
    @State private var selection: String? = nil
    
    var list: some View {
        List(viewModel.races, id: \.self) { item in
            StagesScreenCell(item: item)
                .environmentObject(viewModel)
        }
    }
}

struct StagesScreenCell: View {
    
    @EnvironmentObject var viewModel: StagesScreenViewModel
    var item: Race
    
    var body: some View {
        VStack(alignment: .center, spacing: .none) {
            let name = item.circuit?.circuitName ?? ""
            if let circuit = item.circuit {
                let region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: Double(circuit.location?.lat ?? "") ?? 55.5555555,
                        longitude: Double(circuit.location?.long ?? "") ?? 55.5555555
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.04,
                        longitudeDelta: 0.04
                    ))
                NavigationLink(
                    name,
                    destination: LazyView(CircuitScreen(
                                            circuit: circuit,
                                            region: region))
                        .navigationTitle(name))
            } else {
                Text(name)
            }
            
        }
        .onAppear() {
            if viewModel.races.last == item {
                viewModel.loadItems()
            }
        }
    }
}

struct StagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        let year = "2009"
        let viewModel = StagesScreenViewModel(with: year)
        StagesScreen(viewModel: viewModel)
    }
}
