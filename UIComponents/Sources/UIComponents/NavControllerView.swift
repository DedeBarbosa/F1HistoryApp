//
//  NavControllerView.swift
//  SwiftUIAppNav
//
//  Created by exey on 14.12.2020.
//

import SwiftUI

// Model
@available(iOS 13.0, *)
private struct ScreenStack {
    
    private var screens = [Screen]()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
    
}

@available(iOS 13.0, *)
private struct Screen: Identifiable, Equatable {
    
    let id: String
    let title: String
    let nextScreen: AnyView
    
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

enum NavType {
    case push
    case pop
}

public enum PopDestination {
    case previous
    case root
}

// MARK: - More UI Logic

@available(iOS 13.0, *)
public enum NavTransition {
    case none
    case custom(AnyTransition)
}

@available(iOS 13.0, *)
final class NavControllerViewModel: ObservableObject {
    
    @Published fileprivate var currentScreen: Screen?
    private var screenStack = ScreenStack() {
        didSet {
            currentScreen = screenStack.top()
        }
    }
    
    // for transition
    var navigationType: NavType = .push
    private let easing: Animation
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push<S: View>(_ screenView: S, title: String) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, title: title, nextScreen: AnyView(screenView))
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination = .previous) {
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .root:
                screenStack.popToRoot()
            case .previous:
                screenStack.popToPrevious()
            }
        }
    }
}

@available(iOS 13.0, *)
public struct NavControllerView<Content>: View where Content: View {
    
    @ObservedObject var viewModel: NavControllerViewModel
    var title: String
    
    private let content: Content
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    public init(title: String = "", transition: NavTransition,
                easing: Animation = .easeOut(duration: 0.33),
                @ViewBuilder content: @escaping () -> Content) {
        
        viewModel = NavControllerViewModel(easing: easing)
        self.title = title
        self.content = content()
        
        switch transition {
            case .custom(let trans):
                transitions = (trans, trans)
            case .none:
                transitions = (.identity, .identity)
            
        }
        
    }
    
    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return
            VStack() {
                HStack {
                    if viewModel.currentScreen != nil {
                        NavPopButton(destination: .previous) {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .environmentObject(viewModel)
                    } else {
                        Spacer()
                    }
                    Spacer()
                    Text(viewModel.currentScreen?.title ?? title)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    NavPopButton(destination: .root) {
                        Image(systemName: "house")
                            .font(.system(size: 24, weight: .bold))
                    }
                    .environmentObject(viewModel)
                }
                Spacer()
                ZStack {
                if isRoot {
                    content
                        .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(viewModel)
                } else {
                    viewModel.currentScreen!.nextScreen
                        .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(viewModel)
                }
                Spacer()
            }
        }
    }
}

@available(iOS 13.0, *)
public struct NavPushButton<Label, Destination>: View where Label: View, Destination: View {
    
    @EnvironmentObject var viewModel: NavControllerViewModel
    
    private let destination: (view: Destination, title: String)
    private let label: () -> Label
    
    public init(destination: Destination, title: String, @ViewBuilder label: @escaping () -> Label) {
        self.destination = (view: destination, title: title)
        self.label = label
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .onTapGesture {
                    push()
                }
                .colorInvert()
            label().onTapGesture {
                push()
            }
        }
        
    }
    
    private func push() {
        viewModel.push(destination.view, title: destination.title)
    }
    
}

@available(iOS 13.0, *)
public struct NavPopButton<Label>: View where Label: View {
    
    @EnvironmentObject var viewModel: NavControllerViewModel
    
    private let destination: PopDestination
    private let label: () -> Label
    
    public init(destination: PopDestination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    public var body: some View {
        ZStack {
            //Button("", action: { push() })
            label().onTapGesture {
                push()
            }
        }
    }
    
    private func push() {
        viewModel.pop(to: destination)
    }
    
}

/*
struct NavControllerView_Previews: PreviewProvider {
    static var previews: some View {
        NavControllerView()
    }
}*/
