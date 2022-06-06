//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 09/05/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game) //calls the real content of our app (in the contentview file)s
        }
    }
}
