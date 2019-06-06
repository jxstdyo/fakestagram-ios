//
//  UIViewController+swipe.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 6/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//  Se agrega para que algunos controller tenga la posibilidad de ocultarse con el swipe bottom

import Foundation
import UIKit

class UIViewControllerSwipe: UIViewController {
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
}
