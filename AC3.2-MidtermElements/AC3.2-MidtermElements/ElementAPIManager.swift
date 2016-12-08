//
//  ElementAPIManager.swift
//  AC3.2-MidtermElements
//
//  Created by Miti Shah on 12/8/16.
//  Copyright © 2016 Miti Shah. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    class func getData(apiEndpoint: String, callback: @escaping([Element]?) -> Void)  {
        
        // 1. check if endpoint is valid
        guard let validEndpoint =  URL(string: apiEndpoint) else { return }
        
        // 2. URLSession/Configuration
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // 3. dataTaskWithURL
        session.dataTask(with: validEndpoint) {(data: Data?, response: URLResponse?, error: Error?) in
            
            // 4. check for errors right away
            if error != nil {
                print(error.debugDescription)
            }
            
            // 5. printing out the data
            guard let validData: Data = data else {return}
            
            
            // 6. reuse our code to make some cats from Data
            let elementData = APIRequestManager.manager.getData(from: validData)
            
            // 7. Call the callback
            callback(elementData)
            }.resume()
        
        
    }
    
    func getData(from data: Data) -> [Element]? {
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            var allElements = [Element]()
            
            guard let parsedjson = jsonData as? [[String:Any]] else {return nil}
            
            for json in parsedjson {
                guard let name = json["name"] as? String,
                    let symbol = json["symbol"] as? String,
                    let weight = json["weight"] as? Int,
                    let number = json["number"] as? Int else {return nil}
                
                let meltingPoint = json["melting_c"] as? Int ?? nil
                let boilingPoint = json["boiling_c"] as? Int ?? nil
                
                
                var thumbnailImage = ""
                var FullImage = ""
                let imageEndpoint = "https://s3.amazonaws.com/ac3.2-elements/"
                let shortImageEnding = "_200.png"
                let fullImageEnding = ".png"
                
                

                thumbnailImage += "\(imageEndpoint)\(symbol)\(shortImageEnding)"
                FullImage += "\(imageEndpoint)\(symbol)\(fullImageEnding)"
                
                
                
                
                
                allElements.append(Element(name: name, symbol: symbol, weight: weight, number: number, meltingPoint: meltingPoint, boilingPoint: boilingPoint, thumbnail: thumbnailImage, largestString: FullImage))
                
            }
            return allElements
            
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func postRequest(endPoint: String, data: [String:Any]) {
        guard let url = URL(string: endPoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // this is specifically for the midterm  -- don't change if you want to write there
        request.addValue("Basic a2V5LTE6dHdwTFZPdm5IbEc2ajFBZndKOWI=", forHTTPHeaderField: "Authorization")
        
        do {
            let body = try JSONSerialization.data(withJSONObject: data, options: [])
            request.httpBody = body
        } catch {
            print("Error posting body: \(error)")
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error encountered during post request: \(error)")
            }
            if response != nil {
                let httpResponse = (response! as! HTTPURLResponse)
                print("Response status code: \(httpResponse.statusCode)")
            }
            guard let validData = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: []) as? [String:Any]
                if let validJson = json {
                    print(validJson)
                }
            } catch {
                print("Error converting json: \(error)")
            }
            }.resume()
    }

}
