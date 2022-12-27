//
//  ImageFullViewViewController.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 21/12/22.
//

import UIKit
import SDWebImage

class ImageFullViewViewController: UIViewController {
    
    @IBOutlet weak var imageFullViewCollectionView: UICollectionView!
    @IBOutlet weak var frontImagesCollectionView: UICollectionView!
    
    var allImages = [Image]()
    var defaultImage = UIImage(named: "defaultImage")
    
    var startIndex = 0
    var passIndex = 0
    var checkStatus = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("last controller called")
        print(allImages)
        
        imageFullViewCollectionView.delegate = self
        imageFullViewCollectionView.dataSource = self
        
        frontImagesCollectionView.isPagingEnabled = false
        
       
        
        
        
        
        //   navigationController?.navigationBar.prefersLargeTitles = true
        //       let layout = UICollectionViewFlowLayout()
        //
        //        print("something has changed")
        //        imageFullViewCollectionView.collectionViewLayout = layout
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
//        imageFullViewCollectionView.scrollToItem(at: IndexPath(item: passIndex, section: 0), at: .centeredHorizontally, animated: true)
//
//        frontImagesCollectionView.scrollToItem(at: IndexPath(item: passIndex, section: 0), at: .centeredHorizontally, animated: true)
        print("pass index value \(passIndex)")
        self.collectionView(self.frontImagesCollectionView, didSelectItemAt: IndexPath(item: passIndex, section: 0))

         
      }
    
    
    
}

extension ImageFullViewViewController: UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("image is tapped")
        if collectionView == self.frontImagesCollectionView{
            self.imageFullViewCollectionView.isPagingEnabled = false
            imageFullViewCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            self.imageFullViewCollectionView.isPagingEnabled = true
            self.frontImagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            
        }
        
    }
    
}

extension ImageFullViewViewController: UICollectionViewDataSource, UIScrollViewDelegate{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Total Images")
        print(allImages.count)
        return allImages.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.frontImagesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageFullViewCollectionViewCell
            // cell.imgInvidualImage.image = UIImage(url: allImages[indexPath.row].image_thumb)
            // cell.lblAlbumName.text = "Testing"
            
            
            let baseUrl = "http://34.194.219.62/livewallpaper/"
            let currentUrl = self.allImages[indexPath.row].image_thumb ?? ""
            let mainUrl = baseUrl+currentUrl
            //image
            let url = URL(string: mainUrl)
            //let data = try? Data(contentsOf: url!)
            if let url = url{
                cell.imgFullImage?.sd_setImage(with: url, placeholderImage: defaultImage, context: nil, progress: nil)
            }
            
            // cell.imgInvidualImage.image = UIImage(named: "DSC_0008")
            
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageFullViewCollectionViewCell
            // cell.imgInvidualImage.image = UIImage(url: allImages[indexPath.row].image_thumb)
            // cell.lblAlbumName.text = "Testing"
            
            
            let baseUrl = "http://34.194.219.62/livewallpaper/"
            let currentUrl = self.allImages[indexPath.row].image_thumb ?? ""
            let mainUrl = baseUrl+currentUrl
            //image
            let url = URL(string: mainUrl)
            //let data = try? Data(contentsOf: url!)
            if let url = url{
                cell.imgFullImage?.sd_setImage(with: url, placeholderImage: defaultImage, context: nil, progress: nil)
            }
            
            // cell.imgInvidualImage.image = UIImage(named: "DSC_0008")
            
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.frontImagesCollectionView{
            return CGSize(width: imageFullViewCollectionView.frame.width/3 , height: imageFullViewCollectionView.frame.height)
        }
        else{
            return CGSize(width: imageFullViewCollectionView.frame.width , height: imageFullViewCollectionView.frame.height)
        }
        
        //        return CGSize(width: imageFullViewCollectionView.frame.width , height: imageFullViewCollectionView.frame.height)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.frontImagesCollectionView{
            return 10
        }
        else
        {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.frontImagesCollectionView{
            return 10
        }
        else
        {
            return 0
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        
        if scrollView == self.imageFullViewCollectionView{
            
            for cell in imageFullViewCollectionView.visibleCells{
        
                if  let idexPath =  imageFullViewCollectionView.indexPath(for: cell){
             
                    print("second view index no \(idexPath.row)")
                    
                
                    frontImagesCollectionView.scrollToItem(at: idexPath, at: .centeredHorizontally, animated: true)
                   // self.imageFullViewCollectionView.isPagingEnabled = true
                }
            }
            
        }
        else{
            
            for cell in frontImagesCollectionView.visibleCells{
             
                if  let idexPath =  frontImagesCollectionView.indexPath(for: cell){

                    print(idexPath.row)
                 //  self.frontImagesCollectionView.isPagingEnabled 
                  imageFullViewCollectionView.scrollToItem(at: idexPath, at: .centeredHorizontally, animated: true)
                }
            }
        }
        
        
    }
}

