//
//  ContentView.swift
//  UserLocation
//
//  Created by Bekir Berke Yılmaz on 3.11.2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .tint(.pink)
                .onAppear{
                    viewModel.checkIfLocationServiceIsEnabled()
                }
    }
}

#Preview {
    ContentView()
}
