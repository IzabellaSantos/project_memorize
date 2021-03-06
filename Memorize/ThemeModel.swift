//
//  ThemeModel.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 24/05/22.
//

import Foundation

struct ThemeModel {
    private(set) var themes: Array<Theme> //array with all the themes you can have
    
    //ask how to deal with a non-declared theme string
    mutating func chooseTheme(nameTheme: String) -> Theme {
        var chosenThemeIndex: Int = 0
        
        for index in 0..<themes.count {
            if(themes[index].name.contains(nameTheme)) {
                themes[index].emojis.shuffle()
                chosenThemeIndex = index
            }
        }

        return themes[chosenThemeIndex]
    }
    
    init(){
        themes = Array<Theme>()

        themes.append(Theme(id: 0, name: "Animals", emojis: ["ðŪ", "ðą", "ð­", "ðđ", "ð°", "ðĶ", "ðŧ", "ðž", "ðŊ", "ðĶ", "ð·", "ðķ", "ð", "ðĶ", "ð", "ðĐ", "ðĶŪ", "ðâðĶš", "ð", "ðââŽ", "ð", "ðĶ", "ðĶĪ", "ðĶ", "ðĶ", "ðĶĒ", "ðĶĐ", "ð", "ð", "ðĶ", "ðĶĻ", "ðĶĄ", "ðĶŦ", "ðĶĶ", "ðĶĨ", "ð", "ð", "ðŋ", "ðĶ"], pairs: 5, color: "orange"))
        themes.append(Theme(id: 1, name: "Transportation", emojis: ["âïļ", "ð", "ðē", "ð", "ð", "ð", "ð", "ðī", "ð", "ðķ"], pairs: 3, color: "red"))
        themes.append(Theme(id: 2, name: "Health", emojis: ["ð", "ðĄ", "ðĶ ", "ðĐđ", "ð", "ð§Ž", "ðĐš", "ðĻ"], pairs: 3, color: "green"))
        themes.append(Theme(id: 3, name: "Fruits", emojis: ["ð", "ð", "ðĨ", "ð", "ð", "ðĨĨ", "ð", "ð", "ðĨ", "ð", "ðĨ­", "ðŦ"], pairs: 5, color: "yellow"))
        themes.append(Theme(id: 4, name: "Electronics", emojis: ["ðą", "ðŧ", "âĻïļ", "ðĨ", "ðĻ", "ðą", "âïļ", "ðŋ", "ðĨ", "ðš", "â°", "ð", "ðĄ", "ðļ"], pairs: 4, color: "blue"))
        themes.append(Theme(id: 5, name: "Tools", emojis: ["ðŠ", "ð§", "ðĻ", "âïļ", "ð ", "â", "ðŠ", "ðĐ"], pairs: 2, color: "pink"))
    }
    
    struct Theme: Identifiable {
        var id: Int
        var name: String
        var emojis: [String]
        var pairs: Int
        var color: String
    }
}
