//
//  PostCollectionViewCell.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "postViewCell"
    
    public var post: Post!{
        didSet{
            updateContet()
        }
    }
    

    @IBOutlet weak var totalLikes: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var totalComment: UILabel!
    @IBOutlet weak var autor: PostAuthorView!
    @IBOutlet weak var isLike: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isLike.setImage(UIImage.init(named: "dislike"), for: .normal)
        isLike.setImage(UIImage.init(named: "like"), for: .selected)
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
        descripcion.text = post.title
        totalComment.text = "\(post.commentsCount) comentarios"
        if post.liked {
            isLike.isSelected = false
        } else {
            isLike.isSelected = true
        }
    }

    @IBAction func tapLike(_ sender: UIButton) {
        guard let post = self.post else { return }
        let client = LikeUpdaterClient(post: post)
        self.post = client.call()
        updateContet()
    }
    
    
}
