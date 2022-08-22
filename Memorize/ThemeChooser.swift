//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Izabella Julia dos Santos on 12/08/22.
//

import SwiftUI

struct EmojiMemoryThemeChooser: View {
    @StateObject var store = EmojiMemoryThemeStore()
    @Environment(\.presentationMode) var presentationMode
    @State private var editMode: EditMode = .inactive
    @State private var showThemeEditor = false //exit the edit window
    @State private var editingTheme: EmojiMemoryTheme? //calls the init where the json is (which is saving the themes)
    

    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    ZStack {
                        EmojiThemeRow(theme: theme, isEditing: self.editMode == .active) {
                            self.editingTheme = theme
                        }
                        
                        // An empty NavigationLink so that the "navigation chevron" can be hidden, but still the same "row content" is shown
                        NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
                            Color.clear
                        }
                        .opacity(self.editMode.isEditing ? 0 : 1)
                    }
                }
                .onDelete { indexSet in
                    self.store.themes.remove(atOffsets: indexSet)
                }
            }
            .sheet(item: self.$editingTheme, content: { theme in
                EmojiMemoryThemeEditor(theme: theme)
                    .environmentObject(self.store)
            })
            .navigationBarTitle("Memorize")
            .navigationBarItems(
                leading: addTheme
                .opacity(editMode == .inactive ? 1 : 0),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode) //calls the ThemeEditor
        }
    }
    
    var addTheme: some View {
        Button {
            self.store.themes.append(EmojiMemoryTheme.template) //adds the default theme to the list
        } label: {
            Image(systemName: "plus").imageScale(.large)
        }
    }
}

struct EmojiMemoryThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryThemeChooser()
            .environmentObject(EmojiMemoryThemeStore())
    }
}

struct EmojiThemeRow: View {
    let theme: EmojiMemoryTheme
    let isEditing: Bool
    let editTheme: ()->Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(theme.name)
                    .font(.title)
                    .foregroundColor(self.isEditing ? Color.primary : theme.color)

                HStack {
                    Text("\(theme.numberOfPairs == theme.emoji.count ? "All" : "\(theme.numberOfPairs)") of \(theme.emoji.joined())")
                        .truncationMode(.tail)
                        .lineLimit(1)
                }
            }
            
            Spacer()

            if self.isEditing {
                Button(action: editTheme) {
                    Image(systemName: "pencil.circle.fill")
                        .imageScale(.large)
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(Color.green)
            }
        }
    }
}
