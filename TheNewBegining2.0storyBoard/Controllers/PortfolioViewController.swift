//
//  PortfolioViewController.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 29.06.22.
//

import UIKit

class PortfolioViewController: UIViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var images : [UIImage]!
    var coins : [Coin]!
    var arrOfCoinChoseViews : [CoinChooseView] = []
    private var currentChose = ""
    private var textFieldForAmount : UITextField = UITextField()
    private var textFieldForFiltering : UITextField = UITextField()
    private var addCoinButton : UIButton = UIButton()
    private var stack : UIStackView!

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
        addCoinButton.addTarget(self, action: #selector(addToCoreData(sender:)), for: .touchUpInside)
        view.addSubview(addCoinButton)
        textFieldForFiltering.placeholder = "Please enter the name of the currency"
        textFieldForFiltering.font = UIFont.boldSystemFont(ofSize: 20)
        textFieldForFiltering.textAlignment = .center
        textFieldForFiltering.backgroundColor = .back
        textFieldForFiltering.layer.cornerRadius = 20
        textFieldForFiltering.layer.borderColor = UIColor.cyan.cgColor
        textFieldForFiltering.layer.borderWidth = 3
        textFieldForFiltering.addTarget(self, action: #selector(filter(_:)), for: .allEditingEvents)
        
        view.addSubview(textFieldForFiltering)
        
        
        
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
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: view.frame.width * 0.2).isActive = true
        scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scroll.heightAnchor.constraint(equalToConstant: view.frame.width * 0.3).isActive = true
        textFieldForAmount.translatesAutoresizingMaskIntoConstraints = false
        textFieldForAmount.topAnchor.constraint(equalTo: scroll.bottomAnchor,constant: 30).isActive = true
        textFieldForAmount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFieldForAmount.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        textFieldForAmount.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        
        textFieldForFiltering.translatesAutoresizingMaskIntoConstraints = false
        textFieldForFiltering.topAnchor.constraint(equalTo: scroll.topAnchor,constant: -view.frame.width * 0.15).isActive = true
        textFieldForFiltering.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFieldForFiltering.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        textFieldForFiltering.heightAnchor.constraint(equalToConstant: view.frame.width * 0.1).isActive = true
        addCoinButton.translatesAutoresizingMaskIntoConstraints = false
        addCoinButton.topAnchor.constraint(equalTo: textFieldForAmount.bottomAnchor,constant: 30).isActive = true
        addCoinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack = UIStackView()
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
            
            if (i <= images.count - 1){
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
            
            if let chosenPrevElement = chosenPrevElement,let text = textFieldForFiltering.text,!text.isEmpty,!chosenPrevElement.coin.name.contains(text){
                stack.removeArrangedSubview(chosenPrevElement)
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
    @objc func filter(_ sender : UITextField){
        if let text = sender.text,!text.isEmpty{
            let sortedArray = arrOfCoinChoseViews.filter { coinView in
                coinView.coin.name.contains(text)
            }
            print(coins.indices)
            
            for i in 0...coins.count - 1{
                stack.removeArrangedSubview(arrOfCoinChoseViews[i])
                arrOfCoinChoseViews[i].removeFromSuperview()
            }
            let chosenCoin = arrOfCoinChoseViews.first { coin in
                coin.coin.name == currentChose
            }
            if let chosenCoin = chosenCoin {
                stack.addArrangedSubview(chosenCoin)
            }
            for coinView in sortedArray{
                stack.addArrangedSubview(coinView)
            }
            
            
        }
        else{
            for i in coins.indices{
                stack.addArrangedSubview(arrOfCoinChoseViews[i])
            }
            
        }
        
    }
    @objc func addToCoreData(sender : UIButton){
        
        
        
        let chosenPrevElement = arrOfCoinChoseViews.first { coinChoseView in
            coinChoseView.coin.name == currentChose
        }
        chosenPrevElement?.clearBorder()
        let exp = Expense(context: self.context)
        exp.name = currentChose
        print(textFieldForAmount.text)
        exp.amount = Int64(textFieldForAmount.text ?? "0") ?? 0
        do{
            try context.save()
        }
        catch{
            print("couldnt save your data")
        }
        textFieldForAmount.text = ""
        
      
       
        
        
        self.addCoinButton.isHidden = true
        self.textFieldForAmount.isHidden = true
        currentChose = ""
       
        
        
        
    

        
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
