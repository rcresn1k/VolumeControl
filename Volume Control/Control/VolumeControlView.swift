//
//  VolumeControlView.swift
//  Volume Control
//
//  Created by Rok Cresnik on 16/10/2020.
//

import UIKit

protocol VolumeControlDelegate {
    
    func percentageChanged(_ percentage: Double)
    func volumeChanged(_ volume: Double)

}

class VolumeControlView: CustomView {
    
    var delegate: VolumeControlDelegate?
    
    @IBOutlet weak var sliderSuperview: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet private weak var volumeConstraint: NSLayoutConstraint!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    
    private var config: VolumeControlConfig = .defaultConfig
    private var currentVolume = 0.0
    
    // MARK: - Setup

    override func setup() {
        super.setup()
        
        set(config: .defaultConfig)
    }
    
    func set(config: VolumeControlConfig) {
        self.config = config
        setupUI()
    }
    
    func setupUI() {
        sliderSuperview.backgroundColor = config.disabledColor
        sliderSuperview.layer.borderWidth = 1
        sliderSuperview.layer.borderColor = config.enabledColor.cgColor
        sliderSuperview.clipsToBounds = true
        sliderView.backgroundColor = config.enabledColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        sliderSuperview.addGestureRecognizer(tap)
        
        updateUI()
        layoutIfNeeded()
    }
    
    private func updateUI() {
        currentVolume = max(min(currentVolume, config.maxVolume), config.minVolume)
        let percentage = CGFloat(config.percentageForVolume(volume: currentVolume))
        let height = sliderSuperview.frame.height * percentage
        
        volumeConstraint.constant = height
        volumeTextField.text = String(format: "%.1f", currentVolume)
        percentageTextField.text = String(format: "%.1f", percentage * 100)
        volumeLabel.text = String(format: "Volume set at %.1f%", percentage * 100)
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.sliderSuperview.layoutSubviews()
        }
    }
    
    func set(volume: Double) {
        currentVolume = volume
        
        updateUI()
    }
    
}

// MARK - User actions

extension VolumeControlView {
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            let percentage = Double(1 - sender.location(in: sliderSuperview).y / sliderSuperview.frame.height)
            delegate?.percentageChanged(percentage)
        }
    }
    
    @IBAction private func volumeButtonTapped(_ sender: Any) {
        guard let volume = Double(volumeTextField.text ?? "") else { return }
        
        delegate?.volumeChanged(volume)
    }
    
    @IBAction private func percentageButtonTapped(_ sender: Any) {
        guard let percentage = Double(percentageTextField.text ?? "") else { return }
        
        delegate?.percentageChanged(percentage/100)
    }

}
