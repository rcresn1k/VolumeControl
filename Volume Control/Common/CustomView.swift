//
//  CustomView.swift
//  Volume Control
//
//  Created by Rok Cresnik on 17/10/2020.
//

import UIKit

class CustomView: UIView {
    
    @IBOutlet private weak var contentView: UIView!

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        internalSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last else {
            fatalError("Couldn't load nib")
        }
        // The nib must be named exactly the same as the source files
        _ = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
        
        internalSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup
    
    private func internalSetup() {
        guard let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last else {
            fatalError("Couldn't load nib")
        }
        // The nib must be named exactly the same as the source files
        Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)
        // The following is to make sure content view, extends out all the way to fill whatever our view size is even as our view's size is changed by autolayout
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        addEdgeConstraint(edge: .left, superview: self, subview: contentView)
        addEdgeConstraint(edge: .right, superview: self, subview: contentView)
        addEdgeConstraint(edge: .top, superview: self, subview: contentView)
        addEdgeConstraint(edge: .bottom, superview: self, subview: contentView)

        layoutIfNeeded()

        setup()
    }
    
    private func addEdgeConstraint(edge: NSLayoutConstraint.Attribute, superview: UIView, subview: UIView) {
        let constraint = NSLayoutConstraint(item: subview, attribute: edge, relatedBy: .equal, toItem: superview, attribute: edge, multiplier: 1.0, constant: 0.0)
        superview.addConstraint(constraint)
    }
    
    func setup() {}
    
}

