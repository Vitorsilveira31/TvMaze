//
//  SearchViewController
//  TVMaze
//
//  Created by Vitor Silveira on 07/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let textFieldSearch: UITextField = {
        let search = UITextField()
        
        let placeholder = NSAttributedString(string: "Digite o programa de TV", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.lightGray])
        
        search.attributedPlaceholder = placeholder
        search.font = .systemFont(ofSize: 15)
        search.borderStyle = .roundedRect
        search.autocorrectionType = .no
        search.keyboardType = .default
        search.returnKeyType = .search
        search.clearButtonMode = .whileEditing;
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let buttonSearch: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buscar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupTextFieldSearch()
        setupButtonSearch()
    }
    
    func setupTextFieldSearch() {
        self.view.addSubview(self.textFieldSearch)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(NSLayoutConstraint(item: self.textFieldSearch, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 1))
        
        constraints.append(NSLayoutConstraint(item: self.textFieldSearch, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 1))
        
        constraints.append(NSLayoutConstraint(item: self.textFieldSearch, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: 1))
        
        constraints.append(NSLayoutConstraint(item: self.textFieldSearch, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 1))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func setupButtonSearch() {
        self.buttonSearch.addTarget(self, action: #selector(search), for: .touchUpInside)
        
        self.view.addSubview(self.buttonSearch)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(NSLayoutConstraint(item: self.buttonSearch, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 1))
        constraints.append(NSLayoutConstraint(item: self.buttonSearch, attribute: .top, relatedBy: .equal, toItem: self.textFieldSearch, attribute: .bottom, multiplier: 1, constant: 1))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func search() {
        guard let textoPesquisado = self.textFieldSearch.text, !textoPesquisado.isEmpty else {
            self.showAlert(title: "Erro", message: "Digite algo na barra de pesquisa", preferredStyle: .alert, titleAction: "OK", styleAction: .cancel)
            return
        }
        
        let resultsTableViewController = ResultsTableViewController()
        resultsTableViewController.query = textoPesquisado
        self.navigationController?.pushViewController(resultsTableViewController, animated: true)
        self.textFieldSearch.text = ""
        
    }
}

