//
//  ViewModel.swift
//  Volume Control
//
//  Created by Rok Cresnik on 17/10/2020.
//

import Foundation


class ViewModel {
    
    let volume = Dynamic<Double>(0.0)
    let config = Dynamic<VolumeControlConfig>(.crazyConfig)
    
    required init() {}
    
    init(startVolume: Double, config: VolumeControlConfig) {
        volume.value = startVolume
        self.config.value = config
    }
    
}
