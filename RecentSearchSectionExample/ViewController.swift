//
//  ViewController.swift
//  RecentSearchSectionExample
//
//  Created by ZEUS on 7/3/23.
//

import UIKit

class ViewController: UIViewController {

    let texts = ["Malyesia", "Thiland", "Indonesia", "Singapore", "Vietnam", "What about something that are really long?", "Add short short"]
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        
        let cell = UINib(nibName: "CellWithCollectionview",
                         bundle: nil)
        self.tblView.register(cell,
                              forCellReuseIdentifier: "CellWithCollectionview")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//            for country in self.texts{
//                self.UpdateCollectionView(text: country)
//            }
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
//            for country in self.texts{
//                self.UpdateCollectionView(text: country)
//            }
//        }
    }
    
    //Updating Items after collectionview is fully visible
    func UpdateCollectionView(text: String){
        guard let cell = tblView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CellWithCollectionview else {return}
        tblView.beginUpdates()
        cell.texts.append(text)
        cell.collectionview.reloadData()
        cell.collectionview.layoutIfNeeded()
        tblView.endUpdates()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithCollectionview") as? CellWithCollectionview else {return UITableViewCell()}
        cell.texts = self.texts
        cell.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

//You will need to create a protocol which will cached the size.

public protocol CollectionCellAutoLayout: AnyObject {
    var cachedSize: CGSize? { get set }
}

//Next ,create an extension of the above protocol where it will return the layout information to position it’s cell and supplementary views inside it’s bounds.

public extension CollectionCellAutoLayout where Self: UICollectionViewCell {
    func preferredLayoutAttributes(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
        layoutAttributes.frame = newFrame
        cachedSize = newFrame.size
        return layoutAttributes
    }
}

