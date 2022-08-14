//
//  MonitorViewModel.swift
//  HeatControl
//
//  Created by Illia Kniaziev on 14.08.2022.
//

import Foundation
import Combine

final class MonitorViewModel: ObservableObject {
    
    @Published var temp = 0
    @Published var minTemp = Int.max
    @Published var maxTemp = Int.min
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        updateTemperature()
        
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.updateTemperature()
            })
            .store(in: &subscriptions)
    }
    
    private func updateTemperature() {
        let temp = SwiftSMC.shared.cpuTemperature(sensor: .die)
        if let temp = temp, temp != 1 {
            let intTemp = Int(temp)
            self.temp = intTemp
            minTemp = min(minTemp, intTemp)
            maxTemp = max(maxTemp, intTemp)
        }
    }
    
}
