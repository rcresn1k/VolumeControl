//
//  ViewModel.swift
//  Volume Control
//
//  Created by Rok Cresnik on 17/10/2020.
//

import Foundation


class ViewModel {
    
    let volume = Dynamic<Double>(0.0)
    let config = Dynamic<VolumeControlConfig>(.defaultConfig)
    
    required init() {}
    
    init(startVolume: Double, config: VolumeControlConfig) {
        volume.value = startVolume
        self.config.value = config
    }
    
}

// MARK - Helpers
extension ViewModel {
    
    var percentage: Double {
        config.value.percentageForVolume(volume: volume.value)
    }
    var percentageText: String {
        "\(round(percentage * 100))"
    }
    
    var percentageLabelText: String {
        "Volume set at \(round(percentage * 100))%"
    }
    
    var volumeText: String {
        "\(round(volume.value))"
    }

}

extension ViewModel: VolumeControlDelegate {
    
    func volumeChanged(_ volume: Double) {
        self.volume.value = max(min(volume, config.value.maxVolume), config.value.minVolume)
    }
    
    func percentageChanged(_ percentage: Double) {
        self.volume.value = config.value.volumeForPercentage(percentage: percentage)
    }
    
}


