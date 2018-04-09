//
//  ResultTableViewCell.swift
//  TVMaze
//
//  Created by Vitor Silveira on 07/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    let imageViewResult = UIImageView()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .fromHex(hex: "#242729")
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let labelGenres: UILabel = {
        let label = UILabel()
        label.textColor = .fromHex(hex: "#A0A0A0")
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let buttonFavoriteResult = UIButton()
    
    var delegate: FavoriteDelegate!
    
    var index: IndexPath!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(self.imageViewResult)
        addSubview(self.labelTitle)
        addSubview(self.labelGenres)
        addSubview(self.buttonFavoriteResult)
        
        
        
        let width: CGFloat = UIScreen.main.bounds.width / 3
    
        addContraintsWithFormat("H:|-8-[v0(\(width))]-8-[v1][v2(20)]-8-|", views: self.imageViewResult, self.labelTitle, self.buttonFavoriteResult)
        addContraintsWithFormat("H:|-8-[v0(\(width))]-8-[v1]-8-|", views: self.imageViewResult, self.labelGenres)
        addContraintsWithFormat("V:|-8-[v0]-8-|", views: self.imageViewResult)
        addContraintsWithFormat("V:|-8-[v0(20)]|", views: self.labelTitle)
        addContraintsWithFormat("V:|-8-[v0(20)]-8-[v1(20)]-8-|", views: self.buttonFavoriteResult, self.labelGenres)
        
        self.buttonFavoriteResult.addTarget(self, action: #selector(favorite), for: .touchUpInside)
    }
    
    @objc func favorite() {
        self.delegate.favorite(index: self.index)
    }
    
}
