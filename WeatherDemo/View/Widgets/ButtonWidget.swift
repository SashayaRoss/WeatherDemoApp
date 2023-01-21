//
//  ButtonWidget.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 21/01/2023.
//

import SwiftUI

struct ButtonWidget: View {
    var text: String
    var handler: () -> Void
    
    var body: some View {
        Button {
            handler()
        } label: {
            Text(text)
                .frame(width: 120, height: 50)
                .foregroundColor(.white)
                .textCase(.uppercase)
        }
    }
}

struct ButtonWidget_Previews: PreviewProvider {
    static var previews: some View {
        ButtonWidget(
            text: "today",
            handler: { print("Test")})
        .colorInvert()
    }
}
