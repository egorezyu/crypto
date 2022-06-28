//
//  NetworkManager.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 11.05.22.
//
enum GetDataFromCoinGeckoError : String ,Error{
    case invalidUrl = "something went wrong with url(maybe it was changed in NetworkManagerClas)"
    case badResponse = "bad response or failed cod"
    case badData = "couldnt return data"
    
}
import Foundation
import UIKit
class NetworkManager{
    static var netWork = NetworkManager()
    private let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    
    private init(){
        
    }
    //working with network with escaping completion and result
    func getDataFromCoinGecko(comletion : @escaping ((Result<[Coin],Error>) -> Void)){
        guard let url = URL(string: url) else{
            comletion(.failure(GetDataFromCoinGeckoError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                comletion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                comletion(.failure(GetDataFromCoinGeckoError.badResponse))
                return
            }
            guard let data = data else {
                comletion(.failure(GetDataFromCoinGeckoError.badData))
                return
            }
            do{
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                comletion(.success(coins))
            }
            catch{
                comletion(.failure(error))
            }


        }
        task.resume()
        
        
    }
    //working with the same network through async await keywords
    func getDataFromCoinGecko() async throws -> [Coin]  {
        var coinArray : [Coin] = []
        guard let url = URL(string: url) else{
            throw GetDataFromCoinGeckoError.invalidUrl
        }
        let (data,response) = try await URLSession.shared.data(from: url, delegate: nil)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
                  throw GetDataFromCoinGeckoError.badResponse
              }
        coinArray = try JSONDecoder().decode([Coin].self, from: data)
        
        return coinArray
        
        
    }
    func getImageFromCoin(coin : Coin) async throws -> UIImage {
        var image : UIImage?
//        url = url.appendingPathComponent(name)
//        url = url.appendingPathComponent(imageName + ".png")
//        print(url)
//        guard
//              FileManager.default.fileExists(atPath: url.path) else{
//            return nil
//        }
//        guard var url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
//            return nil
//        }
        
        if let urlForFile = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent("crypto").appendingPathComponent(coin.name + ".png"), FileManager.default.fileExists(atPath: urlForFile.path){
            
            
            
            if let image = getImagesFromFile(coin: coin){
                return image
            }
            else{
                return UIImage(systemName: "questionmark")!
            }
            
        }
        else{
            let localUrl = coin.image
            
            guard let url = URL(string: localUrl) else{
                throw GetDataFromCoinGeckoError.invalidUrl
            }
            let (data,response) = try await URLSession.shared.data(from: url, delegate: nil)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else{
                      throw GetDataFromCoinGeckoError.badResponse
                  }
            
            
            image = UIImage(data: data)
            LocalFileManager.fileManager.saveImage(imageName: coin.symbol, folderName: "crypto", image: image)
            if let image = image {
                return image
            }
            else{
                return UIImage(systemName: "questionmark")!
            }
        }
        
        
        
        
        
    }
    func getImagesFromFile(coin : Coin) -> UIImage?{
        return LocalFileManager.fileManager.getImage(imageName: coin.symbol, name: "crypto")
    }
    func getAllImagesConcurrent(coins : [Coin]) async throws ->[UIImage]{
        try await withThrowingTaskGroup(of: UIImage.self, body: { group in
            var images : [UIImage] = []
            for i in 0...coins.count - 1{
                group.addTask{
                    try await (self.getImageFromCoin(coin: coins[i]))
                }
                
            }
            for try await image in group{
                images.append(image)
            }
            return images
        })
        
    }
    func getAdditionalInfoAboutCoin(coin : Coin) async throws -> CoinDetailModel?{
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else{throw GetDataFromCoinGeckoError.invalidUrl}
        let (data,response) = try await URLSession.shared.data(from: url, delegate: nil)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
                  throw GetDataFromCoinGeckoError.badResponse
              }
        do{
            let result = try JSONDecoder().decode(CoinDetailModel.self,from : data)
            return result
           
            
            
        }
        catch{
            return nil
        }
        
    }
    
    
}
