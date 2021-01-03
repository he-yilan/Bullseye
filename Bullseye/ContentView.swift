//
//  ContentView.swift
//  Bullseye
//
//  Created by Elana Ho on 12/24/20.
//  Copyright © 2020 Elana Ho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var roundNum = 1
    let midnightBlue = Color(red: 0, green: 51/255, blue: 102/255)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y:2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
var body: some View {
    VStack {
        // Target row
        VStack {
            HStack {
                Text("Shoot for")
                    .modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
        .padding(.top, 50)
         Spacer()
        // Slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            
        Spacer()
        // Button row
        Button(action: {
            self.alertIsVisible = true
        }) {
            Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
        }
        .alert(isPresented: $alertIsVisible){ () ->
            Alert in
            let roundedValue = roundSliderValue()
            return Alert(title: Text("\(alertTitle())"),
                         message: Text(
                            "Slider value: \(roundedValue)\n" +
                            "Your score: \(self.pointsForCurrentRound())"
                ),
                         dismissButton: .default(Text("Try Again")) {
                            self.totalScore = self.totalScore + self.pointsForCurrentRound()
                            self.target = Int.random(in: 1...100)
                            self.roundNum = self.roundNum + 1
                })
        }
        .background(Image("Button")).modifier(Shadow())
            
        Spacer()
        // Score row
            HStack {
                Button(action: {
                    self.reset()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Reset").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score: ").modifier(LabelStyle())
                Text("\(totalScore)").modifier(ValueStyle())
                Spacer()
                Text("Round: ").modifier(LabelStyle())
                Text("\(roundNum)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 50)
            
        }
    }
    .background(Image("Background"), alignment: .center)
    .accentColor(midnightBlue)
    .navigationBarTitle("Bull's Eye")
}
    func roundSliderValue() -> Int {
        return Int(sliderValue.rounded())
    }
    func difference() -> Int {
        return abs(target - roundSliderValue())
    }
    func pointsForCurrentRound() -> Int {
        let maxScore = 100
        let diff = difference()
        let bonus: Int
        var awardedPoints = 100 - diff
        if diff == 0 {
            bonus = 100
        }
        else if diff == 1 {
            bonus = 50
        }
        else {
            bonus = 0
        }
        awardedPoints = maxScore - diff + bonus
        return awardedPoints
    }
    func alertTitle() -> String {
        let diff = difference()
        let title: String
        if diff == 0 {
            title = "Perfect!"
        }
        else if diff < 5 {
            title = "You almost had it!"
        }
        else if diff <= 10 {
            title = "Not bad!"
        }
        else {
            title = "Did you even try?"
        }
        return title
    }
    func reset() {
        totalScore = 0
        roundNum = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
