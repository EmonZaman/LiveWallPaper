//
//  TableViewCell.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 19/12/22.
//

import UIKit
import SDWebImage

protocol CellSubclassDelegate: AnyObject {
    func cellItem(cell: TableViewCell, images: [Image], passIndex: Int )
}
class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    weak var delegate: CellSubclassDelegate?
    let defaultImage = UIImage(named: "defaultImage")
    
    var images: [Image]?{
        didSet{
            DispatchQueue.main.async {
                self.categoryCollectionView.reloadData()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        print("Image")
        print(images?.count ?? "0")
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let vc = UISto?.instantiateViewController(withIdentifier: "ImageFullViewViewController") as? ImageFullViewViewController else {
//                  return
//              }
//        print("index section number")
//      //  print(sectionIndex)
//        vc.allImages = self.images
        print("tttttttt")
        if let delegate = self.delegate, let images = images {
            delegate.cellItem(cell: self, images: images, passIndex: indexPath.row)
        }
//
//
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let baseUrl = "http://34.194.219.62/livewallpaper/"
        let currentUrl = self.images?[indexPath.row].image_thumb ?? ""
        let mainUrl = baseUrl+currentUrl
        //image
        let url = URL(string: mainUrl)
        //        let data = try? Data(contentsOf: url!)
        //        if let url = url {
        //            cell.images.image = UIImage(data: data!)
        //        }
        //image
        //let imageUrl:NSURL? = NSURL(string: mainUrl)
        if let url = url{
            cell.imgImage?.sd_setImage(with: url, placeholderImage: defaultImage, context: nil, progress: nil)
        }
        //   cell.images.image = UIImage(named: data[collectionView.tag].images[indexPath.row])
        //cell.collectionView.tag = indexPath.section
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return data[collectionView.tag].images.count
        return self.images?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width/4, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
