//
//  PortfolioViewController.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 29.06.22.
//

import UIKit

class PortfolioViewController: UIViewController {
    var images : [UIImage]!
    var coins : [Coin]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backForCoin
        print(coins.count)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
