//
//  PostDetailViewController.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewControllerSwipe {

    public var post: Post!{
        didSet{
            
        }
    }
    
    @IBOutlet weak var totalLikes: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var totalComment: UILabel!
    @IBOutlet weak var autor: PostAuthorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
