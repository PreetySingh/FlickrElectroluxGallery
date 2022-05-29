//
//  UIImageViewExtensions.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 29/05/22.
//

import Foundation
import UIKit

protocol DownloadIndicatorProtocol {
    func startDownloading()
    func downloadCompleted()
}

extension UIImageView {
    func downloadImage(imageUrl: String, indicatorDelegate: DownloadIndicatorProtocol?) {
        let urlString = UtilityHelper().getImageUrl(pathUrl:imageUrl)
        indicatorDelegate?.startDownloading()
        APIClient.getSharedApiClient().downloadImage(stringURL: urlString) { (photoImage) in
            DispatchQueue.main.async {
                self.image = photoImage
                indicatorDelegate?.downloadCompleted()
            }
        }
    }
}
