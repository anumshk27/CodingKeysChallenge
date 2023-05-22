//
//  ActivityIndicatorView.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit

// Being a subclass of UIView, modify it the way you want
class ActivityIndicatorView: UIView {
    
    // activity indicator
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    // superView
    private weak var superVW : UIView?
    
    init(onView: UIView, andStartAnimation flag: Bool) {
        
        superVW = onView //keep a weak reference of the view on which the animation is happening
        
        super.init(frame: onView.frame)
        
        // view customisations
        backgroundColor = .white
        
        // activity indicator customisations
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
        
        if flag {
            startAnimating()
        }
        
    }
    
    func startAnimating() {
        
        activityIndicator.startAnimating()
        DispatchQueue.main.async {
            self.superVW?.addSubview(self)
        }
        
    }
    
    func stopAnimating() {
        
        activityIndicator.stopAnimating()
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
