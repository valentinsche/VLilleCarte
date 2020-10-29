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
    @State var selected = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack{
                if self.selected == 0 {
                    GeometryReader{_ in
                        
                        MapUIView(vLilleData: vLilleViewModel, selectedStation: nil)
                    }
                }
                else if self.selected == 1 {
                    GeometryReader{_ in
                        ListView(vLilleData: vLilleViewModel)
                    }
                }
                else {
                    GeometryReader{_ in
                        SettingsView()
                    }
                }
            }.background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
            
            FloatingTabbar(selected: self.$selected)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FloatingTabbar : View {
    @Binding var selected : Int
    @State var expand = true
    
    var body : some View {
        HStack{
            Spacer(minLength: 0)
            HStack {
                if !self.expand {
                    Button(action: {
                        self.expand.toggle()
                    }) {
                        Image("worldwide").foregroundColor(.black).padding()
                    }
                }
                else {
                    Button(action: {
                        self.selected = 0
                    }) {
                        Image(systemName: "map.fill").foregroundColor(self.selected == 0 ? .beautifulPink : .gray).padding(.horizontal).font(.title)
                    }
                    Spacer(minLength: 15)
                    Button(action: {
                        self.selected = 1
                    }) {
                        Image(systemName: "text.justify").foregroundColor(self.selected == 1 ? .beautifulPink : .gray).padding(.horizontal).font(.title3)
                    }
                    Spacer(minLength: 15)
                    Button(action: {
                        self.selected = 2
                    }) {
                        Image(systemName: "wrench.fill").foregroundColor(self.selected == 2 ? .beautifulPink : .gray).padding(.horizontal).font(.title3)
                    }
                }
            }
            .padding(.vertical,self.expand ? 20 : 8)
            .padding(.horizontal,self.expand ? 35 : 8)
            .background(Color.veryGrayWhite)
            .clipShape(Capsule())
            .padding(22)
            .onLongPressGesture {
                
                self.expand.toggle()
            }
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6))
        }
    }
}
