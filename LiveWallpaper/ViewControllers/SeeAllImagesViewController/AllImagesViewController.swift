//
//  AllImagesViewController.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 21/12/22.
//

import UIKit
import SDWebImage

class AllImagesViewController: UIViewController {
    
    
    @IBOutlet weak var sellAllImagesCollectionView: UICollectionView!
    
    var allImages = [Image]()
    var defaultImage = UIImage(named: "defaultImage")
    var passIndexValue: Int = 0
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
       // dismiss(animated: true, completion: nil)
        
        sellAllImagesCollectionView.delegate = self
        sellAllImagesCollectionView.dataSource = self

     //   navigationController?.navigationBar.prefersLargeTitles = true
       let layout = UICollectionViewFlowLayout()
        
        print("something has changed")
       sellAllImagesCollectionView.collectionViewLayout = layout

      
    }

}
extension AllImagesViewController: UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("RRR IS sss")
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ImageFullViewViewController") as? ImageFullViewViewController else {
                  return
              }
        print("index section number")
      //  print(sectionIndex)
        vc.allImages = allImages
        print("index path passing value \(indexPath.row)")
        vc.passIndex = indexPath.row
       
        
        self.navigationController?.pushViewController(vc, animated: true)
        
       
        
        
    }
    
}

extension AllImagesViewController: UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       print("Total Images")
        print(allImages.count)
        return allImages.count
    }
   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       let cell = sellAllImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllImagesCollectionViewCell
      // cell.imgInvidualImage.image = UIImage(url: allImages[indexPath.row].image_thumb)
       // cell.lblAlbumName.text = "Testing"
       
       let baseUrl = "http://34.194.219.62/livewallpaper/"
       let currentUrl = self.allImages[indexPath.row].image_thumb ?? ""
       let mainUrl = baseUrl+currentUrl
       //image
       let url = URL(string: mainUrl)
      //let data = try? Data(contentsOf: url!)
       if let url = url{
           cell.imgInvidualImage?.sd_setImage(with: url, placeholderImage: defaultImage, context: nil, progress: nil)
       }
   
      // cell.imgInvidualImage.image = UIImage(named: "DSC_0008")

        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         CGSize(width: UIScreen.main.bounds.width/5, height: 100)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           1      }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
       }
    
    
}


