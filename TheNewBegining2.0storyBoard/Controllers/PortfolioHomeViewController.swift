//
//  PortfolioHomeViewController.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 30.06.22.
//

import UIKit
func degreeToRadians(degree : CGFloat) -> CGFloat{
    return (degree * CGFloat.pi) / 180
    
}

class PortfolioHomeViewController: UIViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrOfCoinChoseViews : [CoinChooseView] = []
    var images : [UIImage]!
    var coins : [Coin]!
    var transformLayer = CATransformLayer()
    var currentAngle : CGFloat = 0
    var currentOffset : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        transformLayer.frame = view.bounds
        view.layer.addSublayer(transformLayer)
        for i in coins.indices {
            let coinChose : CoinChooseView
            
            if (i <= images.count - 1){
                coinChose = CoinChooseView(frame: .zero, coin: coins[i], image: UIImageView(image: images[i]))
                
                
            }
            else{
                coinChose = CoinChooseView(frame: .zero, coin: coins[i], image: UIImageView(image: UIImage(systemName: "questionmark")))
                
            }
            arrOfCoinChoseViews.append(coinChose)
        }
        if let expenses = getDataFromCoreData(){
            for expense in expenses{
                addImageCard(expense: expense)
            }
           
            turnCour()
        }
        let label = UILabel()
        label.text = "Spin to see your current holdings"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
       
        
        
        view.backgroundColor = .backForCoin
        let panJestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(perfomAct(sender:)))
        self.view.addGestureRecognizer(panJestureRecognizer)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transformLayer.sublayers?.removeAll()
        if let expenses = getDataFromCoreData(){
            for expense in expenses{
                addImageCard(expense: expense)
            }
           
            turnCour()
        }
        
    }
    func addImageCard(expense : Expense){
        let imageCardSize = CGSize(width: view.frame.width * 0.2, height: view.frame.width * 0.2)
        let caTextLayer = CATextLayer()
        caTextLayer.string = String(expense.amount)
        caTextLayer.foregroundColor = UIColor.green.cgColor
        caTextLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: (view.frame.size.width / 2 - imageCardSize.width/2), y: (view.frame.size.height / 2 - imageCardSize.height / 2), width: imageCardSize.width, height: imageCardSize.height)
        imageLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        imageLayer.contents = arrOfCoinChoseViews.first(where: { $0.coin.name == expense.name })?.imageView.image?.cgImage
       
        imageLayer.addSublayer(caTextLayer)
        
            
        
        
        imageLayer.contentsGravity = .resizeAspect
        imageLayer.masksToBounds = true
        imageLayer.isDoubleSided = true
        imageLayer.borderColor = UIColor.gray.cgColor
        imageLayer.borderWidth = 3
        
        transformLayer.addSublayer(imageLayer)
    }
    @objc func perfomAct(sender : UIPanGestureRecognizer){
        let xOffset = sender.translation(in: self.view).x
        let xDiff = xOffset * 0.2 - currentOffset
        if sender.state == .began{
            currentOffset = 0
        }
        currentOffset += xDiff
        currentAngle += xDiff
        turnCour()
        
    }
    func turnCour(){
        guard let tran = transformLayer.sublayers else{
            return
        }
        let step = CGFloat(360 / tran.count)
        var angleOffset = currentAngle
        for i in 0...(tran.count - 1){
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 500
            transform = CATransform3DRotate(transform, degreeToRadians(degree: angleOffset), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, 200)
            CATransaction.setAnimationDuration(0)
            tran[i].transform = transform
            angleOffset += step
        }
    }
    func getDataFromCoreData() -> [Expense]?{
        do{
            let expenses = try context.fetch(Expense.fetchRequest())
            return expenses
        }
        catch{
            print(error)
            return nil
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
