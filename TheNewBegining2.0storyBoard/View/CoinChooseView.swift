//
//  CoinChooseView.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 29.06.22.
//

import UIKit

class CoinChooseView: UIControl {
    var imageView : UIImageView!
    var coin : Coin!
    override init(frame : CGRect){
        
        super.init(frame: frame)
    }
    
    convenience init(frame : CGRect,coin : Coin,image : UIImageView?){
        self.init(frame: frame)
       
        self.isUserInteractionEnabled = true
        self.backgroundColor = .backForCoin
        if let image = image{
            self.imageView = image

        }
        else{
            self.imageView = UIImageView(image: UIImage(systemName: "questionmark"))
        }
        self.coin = coin
        let label = UILabel()
        label.text = self.coin.name
        label.font = UIFont.boldSystemFont(ofSize: 10)

        self.addSubview(label)
        self.addSubview(self.imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor,constant: 3).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -30).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
    }
    func drawBorder(){
        
            self.layer.cornerRadius = 25
            self.layer.borderColor = UIColor.green.cgColor
            self.layer.borderWidth = 5
        
            
        
    }
    func clearBorder(){
        
            self.layer.borderColor = UIColor.backForCoin?.cgColor
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
