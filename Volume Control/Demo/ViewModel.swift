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
    
    required init(_ config: VolumeControlConfig = .defaultConfig) {
        self.config.value = config
    }
    
    init(startVolume: Double, config: VolumeControlConfig) {
        volume.value = startVolume
        self.config.value = config
    }
    
}
