//
//  MeidoChanApp.swift
//  MeidoChan
//
//  Created by Toki Fukumoto on 2023/04/02.
//

import SwiftUI

@main
struct MeidoChanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
