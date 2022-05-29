//
//  UtilityHelper.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 29/05/22.
//

import Foundation

struct UtilityHelper {
    func getImageUrl(pathUrl: String?) -> String {
        let baseURL = Constants.URLS.downloadImageBaseUrl
        guard let url = pathUrl else {
            return ""
        }
        let urlString = "\(baseURL)\(url)"
        return urlString
    }
}
