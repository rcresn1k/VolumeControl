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
    private var currentVolume = 0.0 {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Setup

    override func setup() {
        super.setup()
        
        setup(config: .defaultConfig)
    }
    
    func setup(config: VolumeControlConfig) {
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
        let percentage = config.percentageForVolume(volume: currentVolume)
        let height = sliderSuperview.frame.height * CGFloat(percentage)
        
        volumeConstraint.constant = height
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.sliderSuperview.layoutSubviews()
        }
    }
    
    func set(volume: Double,
             volumeText: String,
             percentageText: String,
             percentageLabelText: String) {
        currentVolume = volume
        volumeTextField.text = volumeText
        percentageTextField.text = percentageText
        volumeLabel.text = percentageLabelText
    }
    
}

// MARK - User actions

extension VolumeControlView {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
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
