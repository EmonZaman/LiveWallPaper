//
//  ViewController.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 19/12/22.
//

import UIKit


class WallPaperCategoryViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var wallPaperCategoryTableView: UITableView!
   @IBOutlet weak var menuBarSubView: UIView!
    
    @IBOutlet weak var menuBarTableView: UITableView!
    
    @IBOutlet weak var btnMenuBar: UIButton!{
        didSet{
            self.btnMenuBar.addTarget(self, action: #selector(self.btnMenuBarAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var btnSave: UIButton! {
        didSet {
            self.btnSave.addTarget(self, action: #selector(self.btnSaveAction), for: .touchUpInside)
        }
    }
    
    //MARK: Varriables
    var categories = [Category]()
    var baseModel = [BaseModel]()
    var sectionIndex = 0
    var passIndex = 0
    var isMenuBarHidden = false
    
    
    var menus = [Menu]()
    var mainModel = [MainModel]()
    var defaultImage = UIImage(named: "defaultImage")
    var menuViewController: MenuViewController?
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionIndex = 0
        self.menuBarSubView.isHidden = true
       
        
        self.getWallperData()
        
        print(categories)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController{
            self.menuViewController = controller
            self.add(self.menuViewController ?? controller, frame: self.view.frame)
            
            self.menuViewController?.view.frame = CGRect(x: -UIScreen.main.bounds.width, y: 0, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }

        
        print("loading")
//        self.menuBarTableView.delegate = self
//        self.menuBarTableView.dataSource = self
        self.getMenuData()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wallPaperCategoryTableView.reloadData()
    }
    
    
    
    //MARK: Private Functions
    @objc func buttonAction(sender: UIButton!) {
        print("Button Clicked")
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AllImagesViewController") as? AllImagesViewController else {
            return
        }
        print("index section number")
        
        vc.allImages = self.categories[sender.tag].images!
        
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnMenuBarAction(sender: UIButton!){
        print("MENU")
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
//            return
//        }
//        print("index section number")
//        //  print(sectionIndex)
//        self.navigationController?.pushViewController(vc, animated: true)
//                isMenuBarHidden = !isMenuBarHidden
//                self.menuBarSubView.isHidden = isMenuBarHidden
//        UIView.animate(withDuration: .3, delay: 0) {
//            self.menuview.frame.origin.x = 0
//        }
//        UIView.animate(withDuration: .3, delay: 0) {
//            self.menuview.frame.origin.x = -devicewidth
//        }
//        if let menu = self.menuBarSubView{
//            UIView.animate(withDuration: 0.3, delay: 0.0) {
//                menu.view.frame.origin.x = 0
//            }
//        }
        
        if let menuViewController = self.menuViewController{
            if menuViewController.view.frame.origin.x == 0{
                UIView.animate(withDuration: 0.3, delay: 0.0) {
                    menuViewController.view.frame.origin.x = -UIScreen.main.bounds.width
                }

            }
            else
            {
                UIView.animate(withDuration: 0.3, delay: 0.0) {
                    menuViewController.view.frame.origin.x = 0
                }

            }

        }
        
        
        
    }
    //MARK: Button Actions
    @objc private func btnSaveAction() {
        
    }
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension WallPaperCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("this is tapped")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.menuBarTableView{
            return 80
        }
        else
        {
            return 120
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // data.count
        if tableView == self.menuBarTableView{
            return self.menus.count
        }
        else
        {
            return self.categories.count
        }
        
        
    }
    //        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //            return self.menus[section].name
    //        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.menuBarTableView{
            return self.menus[section].subCategory?.count ?? 2
        }
        else
        {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.menuBarTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuBarSubViewTableViewCell
            let name = self.menus[indexPath.section].subCategory?[indexPath.row].name
            if name == name{
                cell.lblMenuName.text = name
            }
            let baseUrl = "http://34.194.219.62/livewallpaper/"
            let currentUrl = self.menus[indexPath.section].subCategory?[indexPath.row].imageThumb ?? " "
            let mainUrl = baseUrl+currentUrl
            print(currentUrl)
            print(mainUrl)
            //image
            let url = URL(string: mainUrl)
            //        let data = try? Data(contentsOf: url!)
            //        if let url = url {
            //            cell.images.image = UIImage(data: data!)
            //        }
            //image
            //let imageUrl:NSURL? = NSURL(string: mainUrl)
            
            
            if let url = url{
                cell.imgMenuImage?.sd_setImage(with: url, placeholderImage: defaultImage, context: nil, progress: nil)
            }
            else
            {
                cell.imgMenuImage.image = UIImage(named: "DSC_0008")
            }
            //  cell.imgMenuImage.image = UIImage(named: "DSC_0008")
            //  cell.imgMenuBackgroundimage.image = UIImage(named: "DSC_0005")
            print("In Section \(indexPath.section)")
            // print(self.categories.indexPath.row).images?.count)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            cell.categoryCollectionView.tag = indexPath.section
            
            cell.images = self.categories[indexPath.section].images
            
            cell.delegate = self
            print("In Section \(indexPath.section)")
            // print(self.categories.indexPath.row).images?.count)
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // view.tintColor = .green
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == self.menuBarTableView{
            let view = UIView()
            let lblSectionName = UILabel()
            
            lblSectionName.text = self.menus[section].name
            lblSectionName.frame = CGRect(x: 10, y: 5, width: 100, height: 35)
            
            view.addSubview(lblSectionName)
            return view
        }
        else{
            let view = UIView()
            
            // view.backgroundColor = UIColor.orange
            
            let lblSectionName = UILabel()
            
            lblSectionName.text = categories[section].name
            lblSectionName.frame = CGRect(x: 10, y: 5, width: 100, height: 35)
            
            view.addSubview(lblSectionName)
            let btnSellAllButton = UIButton()
            btnSellAllButton.tag = section
            btnSellAllButton.frame = CGRect(x: 340, y: 5, width: 100, height: 35)
            btnSellAllButton.setTitle("See All", for: .normal)
            btnSellAllButton.setTitleColor( .black, for: .normal)
            btnSellAllButton.tintColor = .black
            // sellAllButton.backgroundColor = .black
            //r sellAllButton.backgroundColor = .red
            sectionIndex = section
            
            print("section no is \(section)")
            btnSellAllButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            view.addSubview(btnSellAllButton)
            return view
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
        
    }
    
    
    
    
    
}

extension WallPaperCategoryViewController {
    
    func getWallperData() {
        print("data is calling")
        let email = "app_user@gmail.com"
        let password = "e{AsPzB,W9:?AaSw"
        
        guard !email.isEmpty && !password.isEmpty else {
            return
        }
        let category = "http://34.194.219.62/livewallpaper/api/v1/home"
        
        guard let url = URL(string: category) else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if error == nil {
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(BaseModel.self, from: data) {
                    //data.categories?.first?.images?.first?.category_id
                    
                    //                    self.categories = result.categories ?? []
                    //                                       DispatchQueue.main.async {
                    //                                           self.homeTableView.reloadData()
                    //                                       }
                    self?.categories = data.categories ?? []
                    DispatchQueue.main.async {
                        self?.wallPaperCategoryTableView.reloadData()
                    }
                    print(self?.categories)
                    print("ending")
                    // print(data)
                    
                }
            }
        }.resume()
    }
}

extension WallPaperCategoryViewController: CellSubclassDelegate{
    
    
    func cellItem(cell: TableViewCell, images: [Image], passIndex: Int) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ImageFullViewViewController") as? ImageFullViewViewController else {
            return
        }
        print("index section number")
        //  print(sectionIndex)
        vc.allImages = images
        vc.passIndex = passIndex
        self.present(vc, animated: true)
        
        // self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension WallPaperCategoryViewController{
    
    
    func getMenuData() {
        print("data is calling")
        let email = "app_user@gmail.com"
        let password = "e{AsPzB,W9:?AaSw"
        
        guard !email.isEmpty && !password.isEmpty else {
            return
        }
        let category = "http://34.194.219.62/livewallpaper/api/v1/menu"
        
        guard let url = URL(string: category) else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if error == nil {
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(MainModel.self, from: data) {
                
                    self?.menus = data.menu ?? []
                    DispatchQueue.main.async {
                        self?.menuBarTableView.reloadData()
                    }
                    print("MenuData")
                    print(self?.menus)
                    print("ending")
                    // print(data)
                    
                }
            }
        }.resume()
    }
}
extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}



