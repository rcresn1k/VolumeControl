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
        }
        volumeControl?.delegate = viewModel
        volumeControl?.setup(config: VolumeControlConfig.sabrininConfig)
        
        setupBindings()
    }
    
    // MARK - Bindings

    func setupBindings() {
        viewModel.config.bindAndFire { [weak self] (_, new) in
            self?.volumeControl?.setup(config: new)
        }
        
        viewModel.volume.bindAndFire { [weak self] (_, volume) in
            guard let viewModel = self?.viewModel else { return }
            
            self?.volumeControl?.set(volume: volume,
                                    volumeText: viewModel.volumeText,
                                    percentageText: viewModel.percentageText,
                                    percentageLabelText: viewModel.percentageLabelText)
        }
    }

}

