//
//  ContentView.swift
//  SetGame2021
//
//  Created by Markus Seidler on 14/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, Singapur!")
            .padding()
            .onAppear { let _ = SetOfCards() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
