//
//  AppExtension.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit

extension UIViewController {
    
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }
}

extension UITableView {
    func dequeue<T: UITableViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
}

extension UIImageView {

    func setRounded() {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = (self.frame.width / 2)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
}


extension UIImage{
    
    func inverted() -> UIImage!{
        let context = CIContext()
        let beginImage = CIImage(image: self)
        
        if let filter = CIFilter(name: "CIColorInvert") {
            filter.setValue(beginImage, forKey: kCIInputImageKey)
            if let output = filter.outputImage{
                if let retImg = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: retImg)
                }
            }
        }
        return nil
    }
}



