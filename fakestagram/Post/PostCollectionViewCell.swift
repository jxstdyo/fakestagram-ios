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
    @IBOutlet weak var autor: PostAuthorView!
    @IBOutlet weak var isLike: UIButton!
    @IBOutlet weak var comments: UIButton!
    
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
        descripcion.text = ""
        if post.location.count > 0{
            descripcion.text = "\(post.location)\n"
        }
        descripcion.text = "\(descripcion.text!)\(post.title)"
        comments.setTitle("\(post.commentsCount) comentarios", for: .normal)

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

    @IBAction func showComments(_ sender: Any) {
        guard let post = self.post else { return }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let commentsVC = storyBoard.instantiateViewController(withIdentifier: "commentCollectionView") as! CommentsViewController
        commentsVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        if let id = post.id{
            commentsVC.postId = id
        }
        self.window?.rootViewController?.present(commentsVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addComment(_ sender: Any) {
        if let root = self.window?.rootViewController{
            UIAlert.show(showIn: root, title: "Ingrese el Comentario", placeholder: "<Ingrese el Comentario>") { (comment) in
                guard let post = self.post else { return }
                if let id = post.id{
                    let client = CommentCreateClient(postID: id);
                    let comm = Comment(id: nil, content: comment, author: nil, createdAt: nil, updatedAt: nil)
                    client.create(codable: comm, success: { (result) in
                        guard let data = try? JSONEncoder().encode(self.post) else { return }
                        NotificationCenter.default.post(name: .didCommentPost, object: nil, userInfo: ["post": data as Any] )
                    })
                }
                
            }
        }
    }
    
}
