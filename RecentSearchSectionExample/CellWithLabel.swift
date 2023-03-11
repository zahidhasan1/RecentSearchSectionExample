//
//  CellWithLabel.swift
//  RecentSearchSectionExample
//
//  Created by ZEUS on 7/3/23.
//

import UIKit

class CellWithLabel: UICollectionViewCell, CollectionCellAutoLayout {
    var cachedSize: CGSize?
    

    @IBOutlet weak var viewCont: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        viewCont.layer.masksToBounds = false
        viewCont.layer.cornerRadius = 4
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return preferredLayoutAttributes(layoutAttributes)
    }
}
