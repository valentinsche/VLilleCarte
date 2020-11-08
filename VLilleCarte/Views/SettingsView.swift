//
//  SettingsView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 28/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Code provisoire")) {
                    TextField("Code provisoire", text: $userSettings.temporaryCode)
                    
                }
                Section(header: Text("Signaler un problème sur l'application")) {
                    Button("vLille@gmail.Com") {
                        print("toasty")
                    }
                }
            }
            .navigationTitle("Paramètres")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

class UserSettings: ObservableObject {
    @Published var temporaryCode: String {
        didSet {
            UserDefaults.standard.set(temporaryCode, forKey: "temporaryCode")
        }
    }
    
    init() {
        self.temporaryCode = UserDefaults.standard.object(forKey: "temporaryCode") as? String ?? ""
    }
}
