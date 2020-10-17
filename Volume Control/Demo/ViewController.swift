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
        volumeControl?.delegate = self
        volumeControl?.setup(config: VolumeControlConfig.sabrininConfig)
        
        setupBindings()
    }
    
    // MARK - Bindings

    func setupBindings() {
        viewModel.config.bindAndFire { [weak self] (_, new) in
            self?.volumeControl?.setup(config: new)
        }
        
        viewModel.lines.bindAndFire { [weak self ](_, new) in
            guard let vm = self?.viewModel,
                  new <= vm.config.value.maxVolume,
                  new >= vm.config.value.minVolume
            else { return }
            
            let percentage = vm.percentageForLines(lines: new)
            self?.volumeControl?.linesTextField.text = "\(new)"
            self?.volumeControl?.volumeTextField.text = "\(percentage)"
            self?.volumeControl?.volumeLabel.text = "Volume set at \(percentage) %"
            
            self?.volumeControl?.setVolume(new)
            
        }
        
        viewModel.volumePercentage.bindAndFire { [weak self ](_, new) in
            guard let vm = self?.viewModel,
                new <= 100,
                new >= vm.config.value.minVolume
            else { return }
            
            let lines = vm.linesForPercentage(percentage: new)
            self?.volumeControl?.linesTextField.text = "\(lines)"
            self?.volumeControl?.volumeTextField.text = "\(new)"
            self?.volumeControl?.volumeLabel.text = "Volume set at \(new) %"
            
            self?.volumeControl?.setVolume(lines)
        }
    }

}

// MARK - ViewControlDelegate

extension ViewController: VolumeControlDelegate {
    
    func setVolumeButtonTapped(_ sender: Any) {
        guard let new = Int(volumeControl?.volumeTextField.text ?? "")
        else { return }
        
        viewModel.volumePercentage.value = new
    }
    
    func setLinesButtonTapped(_ sender: Any) {
        guard let new = Int(volumeControl?.linesTextField.text ?? "")
        else { return }
        
        viewModel.lines.value = new
    }
    
    func setLines(_ lines: Int) {
        viewModel.lines.value = lines
    }
    
}

