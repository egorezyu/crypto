//
//  Graphic.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 12.06.22.
//

import UIKit

class Graphic: UIView {
    static var graphicWriter = Graphic()
    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func draw(coin : Coin ,width : Int,height : Int) -> UIImageView{
        let renderer1 = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        let img1 = renderer1.image { ctx in
//            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.cgContext.setLineWidth(1)
            let array = coin.sparklineIn7D?.price ?? []
            let maxY = array.max() ?? 0
            let minY = array.min() ?? 0
            

            let yAxis = maxY - minY
            for index in array.indices{
                let xPosition = CGFloat(width) / CGFloat(array.count) * CGFloat(index + 1)

                let yPosition = (((maxY - array[index]) / yAxis)) * CGFloat(height)
                if (index == 0){
                    ctx.cgContext.move(to: CGPoint(x:xPosition,y:yPosition))
                    
                }
                ctx.cgContext.addLine(to: CGPoint(x:xPosition,y:yPosition))
                
  
            }

//            let rectangle = CGRect(x: 0, y: 0, width: 200, height: 200)
//
            ctx.cgContext.setStrokeColor(coin.priceChange24H ?? 0 > 0 ? UIColor.green.cgColor : UIColor.red.cgColor)
//            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
//
//
//            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .stroke)
            
        }
        return UIImageView(image: img1)
    }
    func drawLine(x : Int,y : Int, width : Int,height : Int) -> UIImage{
        let renderer1 = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        let img1 = renderer1.image { ctx in
//            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.cgContext.setLineWidth(1)
            ctx.cgContext.move(to: CGPoint(x:x,y:height))
            ctx.cgContext.addLine(to: CGPoint(x:x,y:height - y))
            
          
            

            

//            let rectangle = CGRect(x: 0, y: 0, width: 200, height: 200)
//
            ctx.cgContext.setStrokeColor(UIColor.lineColor.cgColor)
//            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
//
//
//            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .stroke)
        }
        return img1
        
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
