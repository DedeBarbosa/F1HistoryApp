//
//  View.swift
//  SwiftUIAppNav
//
//  Created by exey on 07.12.2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    init(_ build: @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
    

