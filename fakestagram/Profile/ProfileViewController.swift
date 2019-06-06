//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var autor: PostAuthorView!
    
    @IBOutlet weak var postsProfile: UICollectionView!
    
    let clientProfile = ProfileClient()
    let clientProfilePosts = ProfilePostsClient()
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        clientProfile.show { (author) in
            self.autor.author = author
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clientProfilePosts.show { (posts) in
            self.posts = posts
            self.postsProfile.reloadData()
        }
    }
    
    func setupUI(){
        postsProfile.delegate = self
        postsProfile.dataSource = self
    }
    
}



extension ProfileViewController :
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        self.posts[indexPath.row].load { (imagen) in
            DispatchQueue.main.async {
                cell.imageTumbs.image = imagen
            }
        }
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let perImageMax = self.postsProfile.frame.width / 3 - 8
        return CGSize(width: perImageMax, height: perImageMax)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = PostDetailViewController(nibName: "PostDetailViewController", bundle: nil)
        detailVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        detailVC.post = self.posts[indexPath.row]
        self.present(detailVC, animated: true, completion: nil)
        
    }
    
}
