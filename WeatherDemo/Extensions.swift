//
//  Extensions.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 15/01/2023.
//

import Foundation
import SwiftUI

extension Double {
    func roundDouble() -> String {
        String(format: "%.0f", self)
    }
}

extension String {
    func temp() -> String {
        self + "°"
    }
    func windSpeed() -> String {
        self + "mph"
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
