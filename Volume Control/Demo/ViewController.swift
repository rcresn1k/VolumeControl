//
//  ViewController.swift
//  Volume Control
//
//  Created by Rok Cresnik on 16/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = ViewModel()
    @IBOutlet private var volumeControl: VolumeControlView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if volumeControl == nil {
            let control = VolumeControlView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 400))
            view.addSubview(control)
            volumeControl = control
            viewModel.config.value = .crazyConfig
        }
        volumeControl?.delegate = self
        
        setupBindings()
    }
    
    // MARK - Bindings

    func setupBindings() {
        viewModel.config.bindAndFire { [weak self] (_, new) in
            self?.volumeControl?.set(config: new)
        }
        
        viewModel.volume.bindAndFire { [weak self] (_, volume) in
            self?.volumeControl?.set(volume: volume)
        }
    }

}

// MARK - VolumeControlDelegate

extension ViewController: VolumeControlDelegate {
    
    func volumeChanged(_ volume: Double) {
        viewModel.volume.value = max(min(volume, viewModel.config.value.maxVolume), viewModel.config.value.minVolume)
    }
    
    func percentageChanged(_ percentage: Double) {
        viewModel.volume.value = viewModel.config.value.volumeForPercentage(percentage: percentage)
    }
    
}
