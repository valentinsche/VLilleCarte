//
//  SettingsView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 28/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Code vélo").font(.headline)) {
                    TextField("Entrez votre code", text: $userSettings.accesscode)
                }
                Section(header: Text("Contacts").font(.headline)) {
                    Text("ok ok ")
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
