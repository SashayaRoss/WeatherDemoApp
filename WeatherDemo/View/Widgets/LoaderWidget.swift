//
//  LoaderWidget.swift
//  WeatherDemo
//
//  Created by Aleksandra Kustra on 15/01/2023.
//

import SwiftUI

struct LoaderWidget: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderWidget()
    }
}
