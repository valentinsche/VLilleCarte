//
//  SettingsView.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 28/10/2020.
//  Copyright © 2020 Valentin Scheldeman. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("toasty")
                }
                Section {
                    Text("ok ok ")
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
