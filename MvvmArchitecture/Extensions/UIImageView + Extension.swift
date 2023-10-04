//
//  UIImageView + Extension.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 04/10/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func getImageFromUrl(url : String) {
        guard let url = URL(string: url) else { return }
        let resource = KF.ImageResource(downloadURL: url)
        kf.setImage(with: resource)
        kf.indicatorType = .activity
    }
    
    
    
}
