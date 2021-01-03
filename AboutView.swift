//
//  AboutView.swift
//  Bullseye
//
//  Created by Elana Ho on 1/2/21.
//  Copyright © 2021 Elana Ho. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let peach = Color(red: 255/255, green: 214/255, blue: 179/255)
    
    struct TitleStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
        }
    }
    
    struct BodyStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.top, 20)
        }
    }
    
    var body: some View {
        Group {
        VStack {
            Text("🎯 Bull's Eye 🎯")
                .modifier(TitleStyle())
                .padding(.top, 20)
            Text("This is Bull's Eye, the game where you can win points and earn fame by dragging a slider. ")
                .modifier(BodyStyle())
            Text("Your goal is to place the slider as close as possible to the target value. The closer you get, the more points you score.")
                .modifier(BodyStyle())
            Text("Your score is the difference between your shot and the target value. You earn +100 bonus points for perfect shots and +50 bonus points for just missing the bull's eye by 1.")
                .modifier(BodyStyle())
            Text("Enjoy!")
                .modifier(BodyStyle())
                .padding(.bottom, 20)
        }
    .navigationBarTitle("About Bull's Eye")
    .background(peach)
    }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
