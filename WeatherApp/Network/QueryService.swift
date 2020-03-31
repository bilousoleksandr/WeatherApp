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
        return tmpArray
    }
    
    
    func getSearchResults (withTerm term: String, onSuccess: @escaping (Model) -> (), onFailure: @escaping (Error) -> () ){
        let searchString = (term as NSString).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: Constants.host + Constants.baseUrl + searchString + Constants.units) else {
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
                onSuccess(decodeResponce)
                
              } catch let parsingError {
                 print("Error", parsingError)
                 onFailure(parsingError)
            }
            
        }
        
        task.resume()
    }
}

private extension QueryService {
    enum Constants {
        static let host = "https://api.openweathermap.org"
        static let baseUrl = "/data/2.5/forecast?q="
        static let units = "&units=metric&appid=a2903a54cfc6a83bd07e7c9d4602977c"
    }
}
