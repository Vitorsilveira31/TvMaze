//
//  ResultViewController.swift
//  TVMaze
//
//  Created by Vitor Silveira on 07/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let imageViewResult = UIImageView()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .fromHex(hex: "#242729")
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let labelGenre: UILabel = {
        let label = UILabel()
        label.textColor = .fromHex(hex: "#A0A0A0")
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let labelPremiered: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .fromHex(hex: "#A0A0A0")
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let textViewDescription: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.setContentOffset(CGPoint.zero, animated: false)
        textView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        textView.contentOffset.y = 0
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.isSelectable = true
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = true
        textView.bounces = true
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainer.lineFragmentPadding = 0;
        textView.textColor = .fromHex(hex: "#242729")
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    let buttonFavoriteResult = UIButton()
    
    var result: ShowModel?
    
    var delegate: FavoriteDelegate!
    
    var index: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupView()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        self.view.addSubview(self.imageViewResult)
        self.view.addSubview(self.labelTitle)
        self.view.addSubview(self.labelGenre)
        self.view.addSubview(self.labelPremiered)
        self.view.addSubview(self.textViewDescription)
        self.view.addSubview(self.buttonFavoriteResult)
        
        let navigationHeight = self.navigationController?.navigationBar.intrinsicContentSize.height ?? 0.0
        let height = self.view.frame.height * 0.6 * (3 / 4)
        self.view.addContraintsWithFormat("H:|[v0]|", views: self.imageViewResult)
        self.view.addContraintsWithFormat("V:|-\(navigationHeight)-[v0(\(height))]-8-[v1(20)]-8-[v2(20)]-8-[v3]|", views: self.imageViewResult, self.labelTitle, self.labelGenre, self.textViewDescription)
        self.view.addContraintsWithFormat("V:|-\(navigationHeight)-[v0(\(height))]-8-[v1(20)]-8-[v2(20)]-8-[v3]|", views: self.imageViewResult, self.buttonFavoriteResult, self.labelPremiered, self.textViewDescription)
        self.view.addContraintsWithFormat("H:|-8-[v0]-8-[v1(20)]-8-|", views: self.labelTitle, self.buttonFavoriteResult)
        self.view.addContraintsWithFormat("H:|-8-[v0][v1(100)]-8-|", views: self.labelGenre, self.labelPremiered)
        self.view.addContraintsWithFormat("H:|-8-[v0]-8-|", views: self.textViewDescription)
        
        self.buttonFavoriteResult.addTarget(self, action: #selector(favorite), for: .touchUpInside)
    }
    
    func setupData() {
        if let data = self.result {
            self.labelTitle.text = data.name
            
            if let dataImage = data.image {
                self.imageViewResult.downloadedFrom(link: dataImage.original)
            } else {
                self.imageViewResult.image = #imageLiteral(resourceName: "sem_imagem_original")
            }
            
            self.imageViewResult.clipsToBounds = true
            self.imageViewResult.contentMode = .scaleToFill
            
            if let genres = data.genres {
                self.labelGenre.getGenre(genres: genres)
            }
            
            if let dataPremiered = data.premiered {
                self.labelPremiered.text = dataPremiered
            }
            
            if let summary = data.summary {
                self.textViewDescription.text = summary.removeHtmlTag()
            }
            
            self.buttonFavoriteResult.setImage(FavoriteUserDefaults.shared.recover().contains(data.id) ? #imageLiteral(resourceName: "favorite_full") : #imageLiteral(resourceName: "favorite_stroke"), for: .normal)
        }
    }
    
    @objc func favorite() {
        if let data = self.result {
            self.delegate.favorite(index: self.index)
            self.buttonFavoriteResult.setImage(FavoriteUserDefaults.shared.recover().contains(data.id) ? #imageLiteral(resourceName: "favorite_full") : #imageLiteral(resourceName: "favorite_stroke"), for: .normal)
        }
    }
    
}
