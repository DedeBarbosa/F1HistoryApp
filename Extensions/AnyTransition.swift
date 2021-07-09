//
//  AnyTransition.swift
//  SwiftUIAppNav
//
//  Created by exey on 14.12.2020.
//

import SwiftUI

@available(iOS 13.0, *)
extension AnyTransition {
    
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
}
