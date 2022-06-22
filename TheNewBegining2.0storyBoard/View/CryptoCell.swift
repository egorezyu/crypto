//
//  CryptoCell.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 12.05.22.
//

import Foundation
import UIKit
class CryptoCell : UITableViewCell{
    private var label = UILabel()
    private let costLabel = UILabel()
    private let priceChangeLabel = UILabel()
    private let image = UIImageView()
    private var graphic = UIImageView()
   
//    private var progress = UIActivityIndicatorView()
    
    
    var stackView = UIStackView()
    override init(style : UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(stackView)
        addSubview(image)
        addSubview(graphic)
        
        configureStack()
        setConstraints()
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        
    }
    func setLabels(coin : Coin,image : UIImage?){
//        progress.startAnimating()
        self.label.text = String(Int(coin.marketCapRank ?? 0)) + ". " + String(coin.symbol).uppercased()
        costLabel.text = coin.currentPrice.format() + "$"
        priceChangeLabel.text = (coin.priceChange24H ?? 0).format() + "$"
//        if let image = image {
//            self.image.image = image
//            progress.stopAnimating()
//            progress.isHidden = true
//
//
//        }
        self.image.image = image
        
        
        self.graphic.image = Graphic.graphicWriter.draw(coin: coin, width: 120, height: 40).image
        
        
        if (coin.priceChange24H ?? 0 > 0){
            priceChangeLabel.textColor = .green
            

        }
        else{
            priceChangeLabel.textColor = .red
        }
        
        
    }
    func configureStack(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        stackView.alignment = .trailing
        stackView.addArrangedSubview(costLabel)
        stackView.addArrangedSubview(priceChangeLabel)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setConstraints(){
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        progress.translatesAutoresizingMaskIntoConstraints = false
//        progress.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
//        progress.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        progress.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        progress.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: image.trailingAnchor,constant: 5).isActive = true
        graphic.translatesAutoresizingMaskIntoConstraints = false
        graphic.leadingAnchor.constraint(equalTo: label.trailingAnchor,constant: 15).isActive = true
        graphic.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        graphic.widthAnchor.constraint(equalToConstant: 120).isActive = true
        graphic.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        graphic.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        graphic.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15).isActive = true
        
        
        
//        cost.translatesAutoresizingMaskIntoConstraints = false
//        cost.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
//        cost.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
        
    }
    
    
}
