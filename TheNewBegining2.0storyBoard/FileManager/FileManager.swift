//
//  FileManager.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 12.06.22.
//

import Foundation
import UIKit
class LocalFileManager{
    static let fileManager = LocalFileManager()
    private init(){
        
    }
    
    func saveImage(imageName : String,folderName : String,image : UIImage?){
        guard let image = image else {
            return
        }

        guard var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return
        }
        url = url.appendingPathComponent(folderName)
        do{
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        catch{
            print(error)
        }
        guard let data = image.pngData()
              else{
                  return
              }
        let imageUrl = url.appendingPathComponent(imageName + ".png")
        do{
           try data.write(to: imageUrl)
        }
        catch{
            print(error)
        }
        
        
        
    }
   
    func getImage(imageName : String ,name : String) -> UIImage?{
        guard var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        url = url.appendingPathComponent(name)
        url = url.appendingPathComponent(imageName + ".png")
        
        guard
              FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path)
        
    }
}
