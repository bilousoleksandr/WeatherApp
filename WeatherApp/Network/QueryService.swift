//
//  QueryService.swift
//  WeatherApp
//
//  Created by Marentilo on 22.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

final class QueryService {
    
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()
    
    static let shared = QueryService()
    
    private init() {}
    
    var weatherModel : Model!
    
    var fiveDays : [List] {
        return getFiveDays()
    }

    func getFiveDays() -> [List] {
        var tmpArray : [List] = []
        let string = weatherModel.list[1].dtTxt.suffix(8)
        for item in weatherModel.list {
            if item.dtTxt.contains(string) {
                tmpArray.append(item)
            }
        }
//        for (index, item) in weatherModel.list.enumerated() {
//            if index % 5 == 0 {
//                tmpArray.append(item)
//            }
//        }
        return tmpArray
    }
    
    
    func getSearchResults (withTerm term: String, onSuccess: @escaping (Model) -> (), onFailure: @escaping (Error) -> () ){
        let searchString = (term as NSString).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(searchString)&units=metric&appid=a2903a54cfc6a83bd07e7c9d4602977c") else {
            return
        }
        
        let task = urlSession.dataTask(with: url) { (data, responce, error) in
            guard let dataResponse = data,
                   error == nil else {
                    onFailure(error!)
                   return }
             do{
                 //here dataResponse received from a network request
                 
                let decodeResponce = try self.decoder.decode(Model.self, from: dataResponse)
                self.weatherModel = decodeResponce
                print(self.weatherModel.cod)
                onSuccess(decodeResponce)
                
              } catch let parsingError {
                 print("Error", parsingError)
                print("Error here")
                 onFailure(parsingError)
            }
            
        }
        
        task.resume()
    }
}
