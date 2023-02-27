//
//  ContentView.swift
//  DungeonDice
//
//  Created by George Sigety on 2/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var resultMessage = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                titleView
                
                Spacer()
                
                resultMessageView
                
                Spacer()
                
                ButtonLayout(resultMessage: $resultMessage)
                
            }
            .padding()

            
        }
    }
}

extension ContentView {
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.red)
    }
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .frame(height: 150)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
