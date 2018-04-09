//
//  Extensions.swift
//  TVMaze
//
//  Created by Vitor Silveira on 07/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import UIKit

extension UIView {
    func addContraintsWithFormat(_ pattern: String, views: UIView...) {
        var mViews = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            mViews["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: pattern, options: NSLayoutFormatOptions(), metrics: nil, views: mViews))
    }
}

extension UILabel {
    func getGenre(genres: [String]) {
        for genre in genres {
            if genre == genres.first {
                self.text = genre
            } else {
                self.text?.append(", \(genre)")
            }
        }
    }
}

extension String {
    func removeHtmlTag() -> String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}

extension UIColor {
    static func fromHex(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        if let cachedImage = CacheImage.cache.imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
        } else {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                    CacheImage.cache.imageCache.setObject(image, forKey: url as AnyObject)
                }
                }.resume()
        }
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
}

extension UIViewController {
    func showAlert(title: String, message: String, preferredStyle: UIAlertControllerStyle, titleAction: String?, styleAction: UIAlertActionStyle?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actionTitle = titleAction, let actionStyle = styleAction {
            alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
