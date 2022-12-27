//
//  MenuViewController.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 26/12/22.
//

import UIKit
import SDWebImage

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!

    
    var menus = [Menu]()
    var mainModel = [MainModel]()
    var defaultImage = UIImage(named: "defaultImage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        self.getMenuData()
        
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        let name = self.menus[indexPath.section].subCategory?[indexPath.row].name
        if name == name{
            cell.lblMenuName.text = name
        }

        
        let baseUrl = "http://34.194.219.62/livewallpaper/"
        let currentUrl = self.menus[indexPath.section].subCategory?[indexPath.row].imageThumb ?? " "
        print("current url is \(currentUrl)")
        let mainUrl = baseUrl+currentUrl
        //image
        let url = URL(string: mainUrl)
     
        
        
        if let url = url{
            cell.imgMenuImage?.sd_setImage(with: url, placeholderImage: defaultImage, context: nil, progress: nil)
        }
        else
        {
            cell.imgMenuImage.image = defaultImage
        }
        
        cell.contentView.backgroundColor = .black
        
        print("In Section \(indexPath.section)")
        // print(self.categories.indexPath.row).images?.count)
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menus[section].subCategory?.count ?? 2
    }

    func numberOfSections(in tableView: UITableView) -> Int {
       return self.menus.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.menus[section].name
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
}

extension MenuViewController{
    
    
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
                        self?.menuTableView.reloadData()
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


