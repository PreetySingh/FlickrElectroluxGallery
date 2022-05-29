//
//  CustomCollectionViewLayout.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation
import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    let sectionInsetConstant: CGFloat = 16
    let itemSpacing: CGFloat = 8
    let screenSize: CGSize?
    
    init(screenSize: CGSize) {
        self.screenSize = screenSize
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        sectionInset = UIEdgeInsets(top: sectionInsetConstant,
                                    left: sectionInsetConstant,
                                    bottom: sectionInsetConstant,
                                    right: sectionInsetConstant)
        guard let screenSize = screenSize else { return }
        let imageViewSize = screenSize.width/3 - (3 * itemSpacing)
        itemSize = CGSize(width: imageViewSize, height: imageViewSize)
        minimumInteritemSpacing = itemSpacing
    }
}
