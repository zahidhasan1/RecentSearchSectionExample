//
//  CellWithCollectionview.swift
//  RecentSearchSectionExample
//
//  Created by ZEUS on 7/3/23.
//

import UIKit

class CellWithCollectionview: UITableViewCell {
    
    
    var texts = [String]()

    @IBOutlet weak var collectionview: UICollectionView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "CellWithLabel", bundle: nil), forCellWithReuseIdentifier: "CellWithLabel")
        let columnLayout = CustomViewFlowLayout()
        columnLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionview.collectionViewLayout = columnLayout
        
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        layout.itemSize = UICollectionViewFlowLayout.automaticSize
//        layout.estimatedItemSize = CGSize(width: 50, height: 50) // Set an initial estimated size for performance
//        collectionview.collectionViewLayout = layout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CellWithCollectionview: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return texts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CellWithLabel", for: indexPath)as? CellWithLabel else {return UICollectionViewCell()}
        cell.lblTitle.text = texts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(texts[indexPath.row])
    }
}


class SelfSizingCollectionView: UICollectionView{
    override var contentSize: CGSize{
        didSet{
            if oldValue.height != self.contentSize.height{
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: CGSize{
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}


class CustomViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
