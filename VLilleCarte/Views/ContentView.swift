//
//  ContentView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 23/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var vLilleViewModel = VLilleViewModel()
    
    var body: some View {
        TabView {
            
            MapUIView(vLilleData: vLilleViewModel)
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Carte")
                }
            ListView(vLilleData: vLilleViewModel)
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Liste")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
