//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Vorapon Sirimahatham on 13/3/21.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
