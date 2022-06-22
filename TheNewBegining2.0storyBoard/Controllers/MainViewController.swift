//
//  ViewController.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 8.05.22.
//

import UIKit

class MainViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var coins : [Coin] = []
    private var images : [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        self.view.backgroundColor = UIColor.back
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CryptoCell.self, forCellReuseIdentifier: "TableViewCell")
        setConstraints()
        setCoinNames()
        print("faf")
        print("def")
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    private func configureTabBar(){
        
        self.navigationItem.title = "Crypto"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    private func setConstraints(){
        let constraints = [ tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

                            ]
       
        

        
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    private func setCoinNames(){
        Task() {
            do{
                let result = try await NetworkManager.netWork.getDataFromCoinGecko()
//                images = try await NetworkManager.netWork.getAllImagesConcurrent(coins: coins)
                self.coins = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                for i in 0...(result.count - 1) {
                    images.append(try await NetworkManager.netWork.getImageFromCoin(coin: result[i]))
//                        images.append(NetworkManager.netWork.getImagesFromFile(coin: result[i]))
                    

                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
              

                
                
                
//                guard var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
//                    return
//                }
//                url = url.appendingPathComponent("crypto")
//                if (FileManager.default.fileExists(atPath: url.path)){
//                    for i in 0...(result.count - 1) {
//    //                    images.append(try await NetworkManager.netWork.getImageFromCoin(coin: result[i]))
//                        images.append(NetworkManager.netWork.getImagesFromFile(coin: result[i]))
//
//                    }
//                }
//                else{
////                    images = try await NetworkManager.netWork.getAllImagesConcurrent(coins: coins)
//                    for i in 0...(result.count - 1) {
//                        images.append(try await NetworkManager.netWork.getImageFromCoin(coin: result[i]))
////                        images.append(NetworkManager.netWork.getImagesFromFile(coin: result[i]))
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//
//                    }
//
//                }
               
                
               

                
                
                
                
                
               
                
                
                
            }
            catch{
                print(error)
            }
        
           
            
        }
        
    }


}
extension MainViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CryptoCell
        let coin = coins[indexPath.row]
        var image : UIImage = UIImage(systemName: "questionmark")!
        
        if (indexPath.row <= images.count - 1){
            image = images[indexPath.row]
        }
        print(indexPath.row)
        
        
        cell.setLabels(coin: coin,image: image)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCoin = coins[indexPath.row]
        var selectedImage : UIImageView
        if ((images.count - 1) <= indexPath.row){
            selectedImage = UIImageView(image: UIImage(systemName: "questionmark"))
        }
        else{
            selectedImage = UIImageView(image: images[indexPath.row])
        }
        
        
        
        let coinViewController = CoinScreenViewController()
        coinViewController.coin = selectedCoin
        coinViewController.coinImage = selectedImage
        navigationController?.pushViewController(coinViewController, animated: true)
        
    }
    
}



