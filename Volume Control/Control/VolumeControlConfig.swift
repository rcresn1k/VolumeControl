//
//  VolumeControlConfig.swift
//  Volume Control
//
//  Created by Rok Cresnik on 16/10/2020.
//

import UIKit

struct VolumeControlConfig {
    
    let minVolume: Int
    let maxVolume: Int
    let enabledColor: UIColor
    let disabledColor: UIColor
    
}

// MARK - Predefined configurations

extension VolumeControlConfig {
    
    public static let defaultConfig = VolumeControlConfig(minVolume: 0,
                                                          maxVolume: 10,
                                                          enabledColor: .blue,
                                                          disabledColor: .gray)
    
    public static let crazyConfig = VolumeControlConfig(minVolume: 0,
                                                        maxVolume: 11,
                                                        enabledColor: .red,
                                                        disabledColor: .yellow)
    
    public static let sabrininConfig = VolumeControlConfig(minVolume: 0,
                                                           maxVolume: 3,
                                                           enabledColor: .cyan,
                                                           disabledColor: .magenta)

}

