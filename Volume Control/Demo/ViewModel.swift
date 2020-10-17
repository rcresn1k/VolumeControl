//
//  ViewModel.swift
//  Volume Control
//
//  Created by Rok Cresnik on 17/10/2020.
//

import Foundation


class ViewModel {
    
    let lines = Dynamic<Int>(0)
    let volumePercentage = Dynamic<Int>(0)
    let config = Dynamic<VolumeControlConfig>(.defaultConfig)
    
    required init() {
        
    }
    
    init(startVolume: Int, config: VolumeControlConfig) {
        lines.value = startVolume
        self.config.value = config
    }
    
    func percentageForLines(lines: Int) -> Int {
        return Int(Double(lines) / Double(config.value.maxVolume - config.value.minVolume) * 100.0)
    }
    
    func linesForPercentage(percentage: Int) -> Int {
        return Int(round(Double(config.value.maxVolume - config.value.minVolume) * Double(percentage) / 100.0))
    }
    
}
