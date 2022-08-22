//
//  ThemeStore.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 24/05/22.
//

import UIKit
import Combine
import SwiftUI

class EmojiMemoryThemeStore: ObservableObject {
    
    @Published var themes: [EmojiMemoryTheme]
    private var autosave: AnyCancellable?

    init() {
        let defaultsKey = "EmojiMemoryThemeStore"
        themes = (UserDefaults.standard.object(forKey: defaultsKey) as? [Data])?
            .compactMap({ EmojiMemoryTheme(json: $0) }) ?? EmojiMemoryTheme.themes
        autosave = $themes.sink { themes in
            UserDefaults.standard.set(themes.map{$0.json}, forKey: defaultsKey)
        }
    }

    // MARK: - Intents
    func updateTheme(for theme: EmojiMemoryTheme, name: String, emoji: [String], colorRGB: UIColor.RGB, numberOfPairs: Int) {
        let newTheme = EmojiMemoryTheme(name: name, emoji: emoji, colorRGB: colorRGB, numberOfPairs: numberOfPairs)
        if let index = themes.firstIndex(matching: theme) {
            themes[index] = newTheme
        }
    }
}
