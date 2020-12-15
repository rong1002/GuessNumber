//
//  ContentView.swift
//  GuessNumber
//
//  Created by Lin Bo Rong on 2020/11/24.
//

import SwiftUI
struct ContentView: View {
    
    var body: some View {
        TabView {
            GuessNumber()
                .tabItem {
                    Text("猜數字")
                    Image(systemName: "textformat.123")
            }
            Guess1A2B()
                .tabItem{
                    Text("1A2B")
                    Image(systemName: "textformat.subscript")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
