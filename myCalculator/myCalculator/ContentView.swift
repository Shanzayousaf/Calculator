//
//  ContentView.swift
//  myCalculator
//
//  Created by Macbook on 30/01/2024.
//

import SwiftUI

enum CalcButton: String{
    
    case one       = "1"
    case two       = "2"
    case three     = "3"
    case four      = "4"
    case five      = "5"
    case six       = "6"
    case seven     = "7"
    case eight     = "8"
    case nine      = "9"
    case zero      = "0"
    case add       = "+"
    case subtract  = "-"
    case multiply  = "X"
    case divide    = "/"
    case clear     = "AC"
    case equal     = "="
    case decimal   = "."
    case percent   = "%"
    case negative  = "+/-"
    
    var buttonColor: Color{
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
            return.orange
        case .clear, .negative, .percent:
            return Color(UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1))
        default: return.gray
        }
    }
}

enum operation {
    case add, subtract, divide, multiply, none
    
}// end of math operator

struct ContentView: View {
    
    @State var value                       = "0"
    @State var runningNumber               = 0
    @State var currentOperation: operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    
    ]
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 70))
                        .foregroundStyle(.white)
                    
                }// end of hstack
                .padding()
                
                // ad buttons
                ForEach(buttons, id: \.self){row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self){item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {Text(item.rawValue)})
                                .frame(
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight()
                                )
                                .font(.system(size: 30))
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(40)
                            
                        }
                        
                    }// end of button hstack
                    .padding(.bottom, 3)
                    
                }// end of ForEach
                
            }// end of 1st vstack
            
        }// end of zstack
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if      button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue  = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                case .add:      self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .divide:   self.value = "\(runningValue / currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero{return((UIScreen.main.bounds.width - (4*12))/4)*2}
        return(UIScreen.main.bounds.width - (5*12))/4
    }
    
    func buttonHeight() -> CGFloat{
        return(UIScreen.main.bounds.width - (5*12))/4
    }
    
    
}

#Preview {
    ContentView()
}
