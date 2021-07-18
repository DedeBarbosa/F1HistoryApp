//
//  CircuitScreen.swift
//  F1HistoryApp
//
//  Created by Dmitry Pavlov on 09.07.2021.
//

import SwiftUI
import Networking
import MapKit

struct CircuitScreen: View {
    
    var circuit: Circuit
    
    @State var region: MKCoordinateRegion
    
    var body: some View {
        return VStack {
            Map(coordinateRegion: $region)
        }
    }
}

struct CircuitScreen_Previews: PreviewProvider {
    static var previews: some View {
        CircuitScreen(
            circuit: Circuit(),
            region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 55.5555555,
                    longitude: 55.555555
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 10,
                    longitudeDelta: 10
                )))
    }
}
