//
//  BigHeaderWidget.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 21/01/2023.
//

import SwiftUI

struct BigHeaderWidget: View {
    var header: String
    
    var body: some View {
        Text(header)
            .font(.system(size: 96,
                          weight: .bold,
                          design: .default))
            .foregroundColor(.white)
    }
}

struct BigHeaderWidget_Previews: PreviewProvider {
    static var previews: some View {
        BigHeaderWidget(header: "17°")
            .colorInvert()
    }
}
