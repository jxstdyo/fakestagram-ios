//
//  TimelineViewController.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    var client = TimeLineClient()
    
    let refreshControl = UIRefreshControl()
    var pageOffset = 1
    var loadingPage = false
    var lastPage = false
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(didLikePost(_:)), name: .didLikePost, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didCommentPost(_:)), name: .didCommentPost, object: nil)
        refreshControl.addTarget(self, action: #selector(self.reloadData), for: UIControl.Event.valueChanged)
        client.show { [weak self] data in
            self?.posts = data
            self?.postsCollectionView.reloadData()
        }
    }
    
    func initUI(){
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        postsCollectionView.prefetchDataSource = self
        postsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        postsCollectionView.addSubview(refreshControl)
    }
    
    @objc func reloadData(){
        pageOffset = 1
        client.show { [weak self] data in
            self?.posts = data
            sleep(1)
            self?.refreshControl.endRefreshing()
            self?.postsCollectionView.reloadData()
        }
    }
    
    func updateCollection(){
        postsCollectionView.reloadData()
    }
    
    @objc func didLikePost(_ notification : NSNotification){
        guard let userInfo = notification.userInfo,
              let data = userInfo["post"] as? Data,
              let json = try? JSONDecoder().decode(Post.self, from: data) else { return }
        if let row = json.row {
            self.posts[row] = json
        }
    }
    
    @objc func didCommentPost(_ notification : NSNotification){
        guard let userInfo = notification.userInfo,
            let data = userInfo["post"] as? Data,
            let json = try? JSONDecoder().decode(Post.self, from: data) else { return }
        
        if let row = json.row {
            if let id = json.id{
                let clientPost = TimePostClient(postID: id)
                clientPost.show { (post) in
                    self.posts[row] = post
                    self.postsCollectionView.reloadData()
                }
                
            }
        }
    }
    
    func loadNextPage() {
        if lastPage { return }
        loadingPage = true
        pageOffset += 1
        client.show(page: pageOffset) { [weak self] posts in
            self?.lastPage = posts.count < 25
            self?.posts.append(contentsOf: posts)
            self?.loadingPage = false
            self?.postsCollectionView.reloadData()
        }
    }
}


extension TimelineViewController : UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if loadingPage { return }
        guard let indexPath = indexPaths.last else { return }
        let upperLimit = posts.count - 5
        if indexPath.row > upperLimit {
            loadNextPage()
        }
    }
}

extension TimelineViewController :
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postViewCell", for: indexPath) as! PostCollectionViewCell
        cell.post = self.posts[indexPath.row]
        cell.post.row = indexPath.row
        cell.backgroundColor = UIColor.Flat.Gray.Iron
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let perImageMax = self.postsCollectionView.frame.width / 1 - 5
        return CGSize(width: perImageMax, height: 600)
    }
    
}
