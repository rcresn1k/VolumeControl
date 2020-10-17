//
//  VolumeControlView.swift
//  Volume Control
//
//  Created by Rok Cresnik on 16/10/2020.
//

import UIKit

protocol VolumeControlDelegate {
    
    func setVolumeButtonTapped(_ sender: Any)
    func setLinesButtonTapped(_ sender: Any)
    func setLines(_ lines: Int)

}

class VolumeControlView: CustomView {
    
    var delegate: VolumeControlDelegate?
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var linesTextField: UITextField!
    
    @IBOutlet private weak var linesStackView: UIStackView!
    
    private var config: VolumeControlConfig = .defaultConfig
    private var currentVolume = 0
    
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
        linesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in config.minVolume...config.maxVolume {
            let view = UIView()
            view.backgroundColor = config.disabledColor
            view.layer.borderWidth = 1
            view.layer.borderColor = config.enabledColor.cgColor
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
            view.addGestureRecognizer(tap)
            linesStackView.addArrangedSubview(view)
        }
    }
    
    func setVolume(_ to: Int) {
        guard to != currentVolume else { return }
        let up = to > currentVolume
        
        isUserInteractionEnabled = false
        
        for index in (up ? currentVolume : to)...(up ? to : currentVolume) {
            let view = linesStackView.arrangedSubviews[index]
            let duration = 0.05
            UIView.animate(withDuration: duration,
                           delay: duration * Double(up ? index : (config.maxVolume - config.minVolume) - index),
                           options: .curveLinear) { [weak self] in
                view.backgroundColor = up ? self?.config.enabledColor : self?.config.disabledColor
                view.layer.borderColor = up ? self?.config.disabledColor.cgColor : self?.config.enabledColor.cgColor
            } completion: { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                self?.currentVolume = to
            }
        }
        
        
        for view in linesStackView.arrangedSubviews[(up ? currentVolume : to)...(up ? to : currentVolume)] {
            let duration = 0.1
            UIView.animate(withDuration: duration,
                           delay: duration,
                           options: .curveLinear) { [weak self] in
                view.backgroundColor = up ? self?.config.enabledColor : self?.config.disabledColor
                view.layer.borderColor = up ? self?.config.disabledColor.cgColor : self?.config.enabledColor.cgColor
            } completion: { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                self?.currentVolume = to
            }

        }
        
    }
    
}

// MARK - User actions

extension VolumeControlView {
    
    @objc private func onTap(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view,
              let index = linesStackView.subviews.firstIndex(of: view)
        else { return }
        
        delegate?.setLines(index)
    }
    
    @IBAction private func setLinesTapped(_ sender: Any) {
        delegate?.setLinesButtonTapped(sender)
    }
    
    @IBAction private func setVolumeTapped(_ sender: Any) {
        delegate?.setVolumeButtonTapped(sender)
    }

}
