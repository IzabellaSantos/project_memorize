//
//  ThemeModel.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 24/05/22.
//

import Foundation

struct ThemeModel{
    private(set) var themes: Array<Theme> //array with all the themes you can have
    
    //ask how to deal with a non-declared theme string
    mutating func chooseTheme(nameTheme: String) -> Theme{
        var chosenThemeIndex: Int = 0
        
        for index in 0..<themes.count{
            if(themes[index].name.contains(nameTheme)){
                themes[index].emojis.shuffle()
                chosenThemeIndex = index
            }
        }

        return themes[chosenThemeIndex]
    }
    
    init(){
        themes = Array<Theme>()

        themes.append(Theme(id: 0, name: "Animals", emojis: ["🐮", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁", "🐷", "🐶"], pairs: 5, color: "orange"))
        themes.append(Theme(id: 1, name: "Transportation", emojis: ["✈️", "🚀", "🚲", "🚁", "🚗", "🚕", "🚎", "🛴", "🚝", "🛶"], pairs: 5, color: "red"))
        themes.append(Theme(id: 2, name: "Health", emojis: ["💊", "🌡", "🦠", "🩹", "💉", "🧬", "🩺", "🏨"], pairs: 4, color: "green"))
        themes.append(Theme(id: 3, name: "Fruits", emojis: ["🍎", "🍐", "🥑", "🍒", "🍓", "🥥", "🍍", "🍇", "🥝", "🍑", "🥭", "🫐"], pairs: 6, color: "yellow"))
        themes.append(Theme(id: 4, name: "Electronics", emojis: ["📱", "💻", "⌨️", "🖥", "🖨", "🖱", "☎️", "💿", "🎥", "📺", "⏰", "🎙", "💡", "📸"], pairs: 7, color: "blue"))
        themes.append(Theme(id: 5, name: "Tools", emojis: ["🪛", "🔧", "🔨", "⚙️", "🛠", "⛏", "🪚", "🔩"], pairs: 4, color: "pink"))
    }
    
    struct Theme: Identifiable{
        var id: Int
        var name: String
        var emojis: [String]
        var pairs: Int
        var color: String
    }
}
