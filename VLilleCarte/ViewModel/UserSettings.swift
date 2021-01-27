//
//  UserSettings.swift
//  VLilleCarte
//
//  Created by Valentin SCHELDEMAN on 27/01/2021.
//  Copyright © 2021 Valentin Scheldeman. All rights reserved.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var accesscode: String {
        didSet {
            UserDefaults.standard.set(accesscode, forKey: "accesscode")
        }
    }
    
    init() {
        self.accesscode = UserDefaults.standard.object(forKey: "accesscode") as? String ?? ""
    }
}
