//
//  CoinScreenViewController.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 12.06.22.
//

import UIKit
@IBDesignable
class CoinScreenViewController: UIViewController {
    var coin : Coin!
    var coinImage : UIImageView!
    var name = UILabel()
    var graphic : UIImageView!
    var line : UIImageView!
    var slider : UISlider!
    var currentPrice : UILabel!
    private var stackView = UIStackView()
    private var max = UILabel()
    private var min = UILabel()
    private var date1 = UILabel()
    private var date2 = UILabel()
    private var overViewLabel = UILabel()
    
    private var formatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter
        
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.slider = UISlider()
        self.currentPrice = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 20.0)
        overViewLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.overViewLabel.text = "Overview".uppercased()
       
        
        
        
        self.slider.minimumValue = 0
        self.slider.maximumValue = Float(coin.sparklineIn7D?.price?.count ?? 0) - 1
        self.max.text = (coin.sparklineIn7D?.price?.max() ?? 0).format()
        self.min.text = (coin.sparklineIn7D?.price?.min() ?? 0).format()
        date1.text = formatter.string(from: Date(coinGeckoString: coin.lastUpdated ?? "").addingTimeInterval(-7 * 24 * 60 * 60))
        date2.text = formatter.string(from: Date(coinGeckoString: coin.lastUpdated ?? ""))
        
        
       
        
        
       
        
        
       
        self.graphic = Graphic.graphicWriter.draw(coin: coin, width: Int(view.frame.width * 0.5), height: Int(view.frame.height * 0.2))
        self.line = UIImageView()
        
        self.line.image = Graphic.graphicWriter.drawLine(x: 0, y: 0, width: Int(view.frame.width * 0.5), height: Int(view.frame.height * 0.2))
        name.text = coin.name.uppercased()
        self.view.backgroundColor = UIColor.backForCoin
        
        
        view.addSubview(graphic)
        view.addSubview(slider)
        view.addSubview(line)
        view.addSubview(coinImage)
        graphic.addSubview(currentPrice)
        view.addSubview(max)
        view.addSubview(min)
        view.addSubview(date1)
        view.addSubview(date2)
        view.addSubview(name)
        view.addSubview(overViewLabel)
        view.addSubview(stackView)
 
        
        max.translatesAutoresizingMaskIntoConstraints = false
        max.trailingAnchor.constraint(equalTo: graphic.leadingAnchor).isActive = true
        max.topAnchor.constraint(equalTo: graphic.topAnchor).isActive = true

        min.translatesAutoresizingMaskIntoConstraints = false
        min.trailingAnchor.constraint(equalTo: graphic.leadingAnchor).isActive = true
        min.bottomAnchor.constraint(equalTo: graphic.bottomAnchor).isActive = true
        coinImage.translatesAutoresizingMaskIntoConstraints = false
        coinImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        coinImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -20).isActive = true
        coinImage.widthAnchor.constraint(equalToConstant:  0.1 * view.frame.width).isActive = true
        coinImage.heightAnchor.constraint(equalToConstant:   0.1 * view.frame.width).isActive = true
        date1.translatesAutoresizingMaskIntoConstraints = false
        date1.leadingAnchor.constraint(equalTo: graphic.leadingAnchor,constant: -20).isActive = true
        date1.topAnchor.constraint(equalTo: graphic.bottomAnchor,constant: 15).isActive = true

        date2.translatesAutoresizingMaskIntoConstraints = false
        date2.trailingAnchor.constraint(equalTo: graphic.trailingAnchor,constant: 20).isActive = true
        date2.topAnchor.constraint(equalTo: graphic.bottomAnchor,constant: 15).isActive = true
        
        overViewLabel.translatesAutoresizingMaskIntoConstraints = false
        overViewLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        overViewLabel.topAnchor.constraint(equalTo: date1.bottomAnchor,constant: 15).isActive = true
        
        
        
        
      
        
        graphic.translatesAutoresizingMaskIntoConstraints = false
        graphic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        graphic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        line.translatesAutoresizingMaskIntoConstraints = false
        line.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        line.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        slider.topAnchor.constraint(equalTo: graphic.bottomAnchor,constant: 3).isActive = true
        slider.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 5).isActive = true
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        currentPrice.translatesAutoresizingMaskIntoConstraints = false
        currentPrice.topAnchor.constraint(equalTo: graphic.topAnchor,constant: -10).isActive = true
        currentPrice.centerXAnchor.constraint(equalTo: graphic.centerXAnchor).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: currentPrice.topAnchor,constant: -20).isActive = true
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        

        // Do any additional setup after loading the view.
    }
    func configureStack(){
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.spacing = 3
//        stackView.alignment = .trailing
//        stackView.addArrangedSubview(costLabel)
//        stackView.addArrangedSubview(priceChangeLabel)
//        
    }
    @objc func sliderValueDidChange(_ sender: UISlider){

        let currentValue = slider.value
        let roundedValue = Int(currentValue.rounded())
        
        print(roundedValue)
        let array = coin.sparklineIn7D?.price
        if let array = array {
            currentPrice.text = String((array[Int(roundedValue)]).format())
            let max = Float(array.max() ?? 0)
            let min = Float(array.min() ?? 0)
            let difference = max - min
            
                            
            let height = Float(view.frame.height * 0.2)
            let current = max - Float(array[roundedValue])
            
            let heightToDrawPoint : Float
            if (current == 0){
                heightToDrawPoint = height
            }
            else{
                heightToDrawPoint = (((Float(array[roundedValue]) - min) / difference)) * Float(height)
            }
           
            
            
            let w = view.frame.width * 0.5
            
            
            let widthToDrawPoint =  Float(w) / Float(array.count) * Float((roundedValue + 1))
            self.line.image = Graphic.graphicWriter.drawLine(x: Int(widthToDrawPoint), y: Int(heightToDrawPoint), width: Int(view.frame.width * 0.5), height: Int(view.frame.height * 0.2))
            
            
        }
        else{
            currentPrice.text = String(roundedValue)
        }
        
        
        
        
        slider.setValue(Float(roundedValue), animated: true)
        
    }
//    func draw(coin : Coin ,width : Int,height : Int) -> UIImageView{
//        let renderer1 = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
//        let img1 = renderer1.image { ctx in
////            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
//            ctx.cgContext.setLineWidth(1)
//            let array = coin.sparklineIn7D?.price ?? []
//            let maxY = array.max() ?? 0
//            let minY = array.min() ?? 0
//
//
//            let yAxis = maxY - minY
//            for index in array.indices{
//                let xPosition = CGFloat(width) / CGFloat(array.count) * CGFloat(index + 1)
//
//                let yPosition = (((maxY - array[index]) / yAxis)) * CGFloat(height)
//                if (index == 0){
//                    ctx.cgContext.move(to: CGPoint(x:xPosition,y:yPosition))
//                }
//                ctx.cgContext.addLine(to: CGPoint(x:xPosition,y:yPosition))
//
//
//            }
//
////            let rectangle = CGRect(x: 0, y: 0, width: 200, height: 200)
////
//            ctx.cgContext.setStrokeColor(coin.priceChange24H ?? 0 > 0 ? UIColor.green.cgColor : UIColor.red.cgColor)
////            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
////
////
////            ctx.cgContext.addRect(rectangle)
//            ctx.cgContext.drawPath(using: .stroke)
//        }
//        return UIImageView(image: img1)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
