//
//  CommentsViewController.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/31/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewControllerSwipe {

    @IBOutlet weak var collectionComments: UICollectionView!
    
    private var client = CommentClient(postID : 0)
    var postId: Int = 0
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        client.show { (comments) in
            self.comments = comments
            self.collectionComments.reloadData()
        }
    }
    
    func setupUI(){
        collectionComments.delegate = self
        collectionComments.dataSource = self
        collectionComments.register(UINib(nibName: "CommentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CommentCollectionViewCell.identifier)
        self.client = CommentClient(postID : postId)
    }
    
    @IBAction func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    
}




extension CommentsViewController :
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCollectionViewCell.identifier, for: indexPath) as! CommentCollectionViewCell
        let comment = self.comments[indexPath.row]
        cell.author = comment.author
        cell.comment.text = comment.content
        cell.backgroundColor = UIColor.Flat.Gray.WhiteSmoke
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header = HeaderSupplementaryView()
        
        if kind == UICollectionView.elementKindSectionHeader{
            header = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyHeader", for: indexPath) as? HeaderSupplementaryView)!
        }
        
        header.headerLabel.text = "Comentarios"
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
    
}


private final class SeparatorView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        self.frame = layoutAttributes.frame
    }
}
