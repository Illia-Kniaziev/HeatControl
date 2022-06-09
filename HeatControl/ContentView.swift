//
//  ContentView.swift
//  HeatControl
//
//  Created by Illia Kniaziev on 09.06.2022.
//

import Cocoa
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(getTempString())
            .padding()
    }
    
    func getTempString() -> String {
        let temp = SwiftSMC.shared.cpuTemperature(sensor: .die)
        return temp == nil ? "No temperature date fetched" : "\(temp!)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
