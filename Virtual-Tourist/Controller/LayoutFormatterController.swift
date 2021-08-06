//
//  LayoutFormatterController.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 06/08/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

extension AlbumController {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 150
        let width: CGFloat = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: Int(width), height: Int(height))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
