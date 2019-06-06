//
//  CommentCollectionViewCell.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/31/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
@IBDesignable
class CommentCollectionViewCell: UICollectionViewCell {

    static let identifier = "commentCollectionViewCell"
    
    var author: Author? {
        didSet { updateView() }
    }
    let avatarView: SVGView = {
        let svg = SVGView()
        svg.translatesAutoresizingMaskIntoConstraints = false
        return svg
    }()
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lorem Ipsum"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    var comment: UILabel = {
        let commentTitle = UILabel()
        commentTitle.text = "Lorem Ipsum Comment"
        commentTitle.font = UIFont(name: "Helvetica", size: 12)
        commentTitle.translatesAutoresizingMaskIntoConstraints = false
        return commentTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
      
        
        addSubview(avatarView)
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            avatarView.widthAnchor.constraint(equalToConstant: 26),
            avatarView.heightAnchor.constraint(equalToConstant: 26)
            ])
        
        addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            nameLbl.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            nameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            nameLbl.heightAnchor.constraint(equalToConstant: 32)
            ])
        
        addSubview(comment)
        NSLayoutConstraint.activate([
            comment.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 3),
            comment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            comment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            comment.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
        
        
    }
    
    private func updateView() {
        guard let author = self.author else { return }
        nameLbl.text = author.name
        avatarView.loadContent(from: author.avatarURL(), authorId: author.id!)
    }
    
    

}
