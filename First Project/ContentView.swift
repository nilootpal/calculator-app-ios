//
//  ContentView.swift
//  First Project
//
//  Created by Nilootpal Das on 13/12/22.
//

import SwiftUI

enum calculatorMode {
    case notSet
    case addition
    case subtraction
    case multiplication
}

struct ContentView: View {
    @State var currentValue = "0"
    @State var currentMode: calculatorMode = .notSet
    @State var lastButtonWasMode = false
    @State var savedNum = 0
    @State var currValueInt = 0
    
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                TotalText(value: currentValue)
                HStack {
                    CalculatorButton(buttonText: "1", action: didPressNumber)
                    CalculatorButton(buttonText: "2", action: didPressNumber)
                    CalculatorButton(buttonText: "3", action: didPressNumber)
                    CalculatorButton(buttonText: "+", color: .orange, action: didPressMode, mode: .addition)
                }
                HStack {
                    CalculatorButton(buttonText: "4", action: didPressNumber)
                    CalculatorButton(buttonText: "5", action: didPressNumber)
                    CalculatorButton(buttonText: "6", action: didPressNumber)
                    CalculatorButton(buttonText: "-", color: .orange, action: didPressMode, mode: .subtraction)
                }
                HStack {
                    CalculatorButton(buttonText: "7", action: didPressNumber)
                    CalculatorButton(buttonText: "8", action: didPressNumber)
                    CalculatorButton(buttonText: "9", action: didPressNumber)
                    CalculatorButton(buttonText: "*", color: .orange, action: didPressMode, mode: .multiplication)
                }
                HStack {
                    CalculatorButton(buttonText: "0", width: 148, action: didPressNumber)
                    CalculatorButton(buttonText: "C", color: .gray, action: didPressClear)
                    CalculatorButton(buttonText: "=", color: .orange, action: didPressEquals)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func didPressNumber(button: CalculatorButton) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            currValueInt = 0
        }
        
        if let parsedValue = Int("\(currValueInt)" + button.buttonText){
            currValueInt = parsedValue
            updateText()
        }
        else{
            currentValue = "Error!!"
            currValueInt = 0
        }
    }
    
    func didPressMode(button: CalculatorButton) {
        currentMode = button.mode
        lastButtonWasMode = true
    }
    
    func didPressEquals(button: CalculatorButton) {
        if lastButtonWasMode || currentMode == .notSet {
            return
        }
        
        if currentMode == .addition {
            savedNum += currValueInt
        } else if currentMode == .subtraction {
            savedNum -= currValueInt
        } else if currentMode == .multiplication {
            savedNum *= currValueInt
        }
        
        currValueInt = savedNum
        updateText()
        lastButtonWasMode = true
    }
    
    func didPressClear(button: CalculatorButton) {
        savedNum = 0
        currValueInt = 0
        currentValue = "0"
        lastButtonWasMode = false
        currentMode = .notSet
    }
    
    func updateText() {
        if currentMode == .notSet {
            savedNum = currValueInt
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let num = NSNumber(value: currValueInt)
        
        currentValue = numberFormatter.string(from: num) ?? "Error"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
