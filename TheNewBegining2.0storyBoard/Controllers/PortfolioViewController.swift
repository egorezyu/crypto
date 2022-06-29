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
    var arrOfCoinChoseViews : [CoinChooseView] = []
    private var currentChose = ""
    private var textFieldForAmount : UITextField = UITextField()
    private var addCoinButton : UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backForCoin
        textFieldForAmount.placeholder =  "Please enter amount of coins"
        textFieldForAmount.font = UIFont.boldSystemFont(ofSize: 20)
        textFieldForAmount.textAlignment = .center
        textFieldForAmount.backgroundColor = .back
        textFieldForAmount.layer.cornerRadius = 20
        textFieldForAmount.layer.borderColor = UIColor.cyan.cgColor
        textFieldForAmount.layer.borderWidth = 3
        textFieldForAmount.keyboardType = .numberPad
        textFieldForAmount.isHidden = true
        textFieldForAmount.addTarget(self, action: #selector(showButton(_:)), for: .allEditingEvents)
        view.addSubview(textFieldForAmount)
        addCoinButton.setTitle("Add to portfolio", for: .normal)
        addCoinButton.setTitleColor(.cyan, for: .normal)
        addCoinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        addCoinButton.layer.borderColor = UIColor.cyan.cgColor
        addCoinButton.layer.borderWidth = 3
        addCoinButton.layer.cornerRadius = 15
        addCoinButton.isHidden = true
        view.addSubview(addCoinButton)
        
        
        
//        print(coins.count)
        
//        coinChose.addTarget(self, action: #selector(onClickEvent(sender:)), for: .touchUpInside)
//        view.addSubview(coinChose)
//        coinChose.translatesAutoresizingMaskIntoConstraints = false
//        coinChose.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        coinChose.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        coinChose.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
//        coinChose.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3).isActive = true
        let scroll = UIScrollView()
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scroll.heightAnchor.constraint(equalToConstant: view.frame.width * 0.3).isActive = true
        textFieldForAmount.translatesAutoresizingMaskIntoConstraints = false
        textFieldForAmount.topAnchor.constraint(equalTo: scroll.bottomAnchor,constant: 30).isActive = true
        textFieldForAmount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFieldForAmount.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        textFieldForAmount.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        addCoinButton.translatesAutoresizingMaskIntoConstraints = false
        addCoinButton.topAnchor.constraint(equalTo: textFieldForAmount.bottomAnchor,constant: 30).isActive = true
        addCoinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let stack = UIStackView()
        scroll.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor).isActive = true
        
        stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        for i in coins.indices {
            let coinChose : CoinChooseView
            
            if (i <= images.count - 1 ){
                coinChose = CoinChooseView(frame: .zero, coin: coins[i], image: UIImageView(image: images[i]))
                
                
            }
            else{
                coinChose = CoinChooseView(frame: .zero, coin: coins[i], image: UIImageView(image: UIImage(systemName: "questionmark")))
                
            }
            arrOfCoinChoseViews.append(coinChose)
            coinChose.addTarget(self, action: #selector(onClickEvent(sender:)), for: .touchUpInside)
            
           
            
            stack.addArrangedSubview(coinChose)
            coinChose.translatesAutoresizingMaskIntoConstraints = false
            coinChose.widthAnchor.constraint(equalToConstant: view.frame.width * 0.3).isActive = true
            coinChose.heightAnchor.constraint(equalToConstant: view.frame.width * 0.3).isActive = true
        }
       
        
//
        

        // Do any additional setup after loading the view.
    }
    @objc func onClickEvent(sender : CoinChooseView){
        textFieldForAmount.isHidden = false
//        if (!sender.isToogled){
//            sender.layer.cornerRadius = 25
//            sender.layer.borderColor = UIColor.green.cgColor
//            sender.layer.borderWidth = 5
//        }
//        else{
//            sender.layer.borderColor = UIColor.backForCoin?.cgColor
//        }
//        sender.isToogled.toggle()
        if (currentChose == ""){
            currentChose = sender.coin.name
            let chosenElement = arrOfCoinChoseViews.first { coinChoseView in
                coinChoseView.coin.name == currentChose
            }
            chosenElement?.drawBorder()
            
            
            
        }
        else{
            let chosenPrevElement = arrOfCoinChoseViews.first { coinChoseView in
                coinChoseView.coin.name == currentChose
            }
            chosenPrevElement?.clearBorder()
            currentChose = sender.coin.name
            let chosenElement = arrOfCoinChoseViews.first { coinChoseView in
                coinChoseView.coin.name == currentChose
            }
            chosenElement?.drawBorder()
            
            
        }
        

    }
    @objc func showButton(_ sender : UITextField){
        if let text = sender.text,!text.isEmpty{
            addCoinButton.isHidden = false
            
        }
        else{
            addCoinButton.isHidden = true
        }
        
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
