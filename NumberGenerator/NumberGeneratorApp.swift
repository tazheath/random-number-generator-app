//
//  NumberGeneratorApp.swift
//  NumberGenerator
//
//  Created by Taz Heath on 2/10/23.
//

import SwiftUI

@main
struct NumberGeneratorApp: App {
    
    init() {
        ATTAuthorization.requestIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
