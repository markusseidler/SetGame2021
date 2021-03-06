//
//  LaunchView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 16/1/21.
//

import SwiftUI

import SwiftUI

struct LaunchView: View {
    
    // This view shows a launchscreen. The Mata Logo appears and disappears on a black screen. A private function helps to manage the animation. Automatic transition to the next view. Transition of views is managed by adjusting opacity.
    
    // MARK: - Private API
    
    @State private var logoOpacity: Double = 0
    @State private var backgroundOpacity: Double = 1
    @State private var pushToNewScreen = false
    
    private let logo = "MataLogoWithSlogan"
    private let logoDuration: Double = 1.0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                        .opacity(backgroundOpacity)
                    Image(logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: min(geometry.size.width / 2, geometry.size.height / 2))
                        .opacity(logoOpacity)
                    NavigationLink(
                        destination: GameViewNew(),
                        isActive: $pushToNewScreen,
                        label: {
                            EmptyView()
                        })
                }
                .navigationBarHidden(true)
                .statusBar(hidden: true)
                .onAppear {
                    Animations.delayedAction(by: 1, duration: logoDuration) { logoOpacity = 1.0 }
                    Animations.delayedAction(by: 3, duration: logoDuration) { logoOpacity = 0.0 }
                    Animations.delayedAction(by: 5, duration: logoDuration) { pushToNewScreen = true }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(GlobalAspect())
        .environmentObject(SetGame(shuffleCards: false))
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPreview { LaunchView() }
    }
}
