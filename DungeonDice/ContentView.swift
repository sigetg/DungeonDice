//
//  ContentView.swift
//  DungeonDice
//
//  Created by George Sigety on 2/19/23.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    @State private var resultMessage = ""
    @State private var buttonsLeftOver = 0 //number of buttons in a less than full row
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0 // between buttons
    let buttonWidth: CGFloat = 102
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Dungeon Dice")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.red)
                Spacer()
                Text(resultMessage)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(height: 150)
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                    ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            resultMessage = "You Rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                
                HStack {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            resultMessage = "You Rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            .padding()
            .onChange(of: geo.size.width, perform: { newValue in
                arrageGridItems(geo: geo)
            })
            .onAppear {
                arrageGridItems(geo: geo)
            }
            
        }
    }
    
    func arrageGridItems(geo: GeometryProxy) {
        var screenWidth = geo.size.width - horizontalPadding*2 //padding on both sides
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        //calculate numOfButtonsPerRow as an Int
        let numOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numOfButtonsPerRow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
