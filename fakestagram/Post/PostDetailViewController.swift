//
//  PostDetailViewController.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {

    public var post: Post!{
        didSet{
            
        }
    }
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    @IBOutlet weak var totalLikes: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var totalComment: UILabel!
    @IBOutlet weak var autor: PostAuthorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        self.view.addGestureRecognizer(gesture)
        updateContet()
    }
    
    func updateContet(){
        guard let post = self.post else {
            return
        }
        //Evita referencia circulares para los hilos
        post.load { [weak self] (imagen) in
            DispatchQueue.main.async {
                self?.imagen.image = imagen
            }
        }
        autor.author = post.author
        totalLikes.text = "\(post.likesCount) Me gusta"
        descripcion.text = "\(post.title)\n \(post.location)"
    }
    
}

extension PostDetailViewController{
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
