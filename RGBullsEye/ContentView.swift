//
//  ContentView.swift
//  RGBullsEye
//
//  Created by Nathan Gross on 11/15/19.
//  Copyright © 2019 Nathan Gross. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert: Bool = false
    
    @ObservedObject var timer = TimeCounter()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget,
                              green: gTarget,
                              blue: bTarget)
                        self.showAlert ? Text("R: \(Int(rTarget * 255.0))"
                        + " G: \(Int(gTarget * 255.0))"
                        + " B: \(Int(bTarget * 255.0))")
                            : Text("Match this color")
                    }
                    VStack {
                        ZStack(alignment: .center) {
                            Color(red: rGuess,
                                  green: gGuess,
                              blue: bGuess)
                            Text(String(timer.counter))
                                .padding(.all, 5)
//                                .frame(width: 48, height: 48)
                                .background(Color.white)
                                .mask(Circle())
                                .foregroundColor(.black)
                        }
                        Text(
                            "R: \(Int(rGuess * 255.0)) G: \(Int(rGuess * 255.0)) B: \(Int(rGuess * 255.0))")
                    }
                }
                Button(action: {
                    self.showAlert = true
                    self.timer.killTimer()
                }) {
                    Text("Hit Me!")
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"),
                    message: Text(String(computeScore())))
                }.padding()
                
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $gGuess, textColor: .green)
                    ColorSlider(value: $bGuess, textColor: .blue)
                }.padding(.horizontal)
                
            }
        }
    }
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff ) * 100.0 + 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5,
                    gGuess: 0.5,
                    bGuess: 0.5)
            .previewLayout(.fixed(width: 568, height:568))
//            .environment(\.colorScheme, .dark)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
            Text("255").foregroundColor(textColor)
        }
        .padding()
    }
}
