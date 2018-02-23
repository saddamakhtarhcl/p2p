//
//  BaseModel.swift
//
//  Copyright, Manchester United Ltd, 2016
//

import Foundation

// MARK: - Model Protocol

protocol BaseModel {
    
    //    typealias T
    
    static func instanceFromDictionary(_ dictionary: [String: Any]?) -> Any?
    static func instanceFromData(_ data: Data) -> Any?
    static func instanceFromFile(_ fileName: String) -> Any?
    
    static func arrayFromData(_ data: Data) -> [Any]?
    static func arrayFromFile(_ fileName: String) -> [Any]?
    
    static func dataFromArray(_ array: [BaseModel]) -> Data?
    static func dataFromInstance(_ model: BaseModel) -> Data?
    
    func dictionaryRepresentation() -> [String: Any]?
    func setAttributesFromDictionary(_ dictionary: [String: Any]?)
}

// MARK: - BaseModel extension

extension BaseModel {
    
    // MARK: - BaseModel Protocol Implementation
    
    // Implementation of base functions which can
    // be used by the BaseModel conforming classes
    
    static func instanceFromData(_ data: Data) -> Any? {
        do {
            let jsonDict: [String: Any]? =
                try JSONSerialization.jsonObject(with: data,
                                                 options: .allowFragments) as? [String: Any]
            
            if jsonDict != nil {
                return instanceFromDictionary(jsonDict! as [String: Any])
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func instanceFromFile(_ fileName: String) -> Any? {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        if path != nil {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) {
                return instanceFromData(data)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func arrayFromData(_ data: Data) -> [Any]? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if let jsonArray = jsonObject as? [Any] {
                var objectCollection: [Any] = [Any]()
                
                for jsonDict in jsonArray {
                    if let dict = jsonDict as? [String: Any] {
                        objectCollection.append(instanceFromDictionary(dict)!)
                    }
                }
                
                return objectCollection
            }
        } catch {
            //App.logger.debugLog(error)
        }
        
        return nil
    }
    
    static func arrayFromFile(_ fileName: String) -> [Any]? {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        if path != nil {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) {
                return arrayFromData(data)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func dataFromArray(_ array: [BaseModel]) -> Data? {
        var dictionaryArray = [[String: Any]]()
        
        for model in array {
            if let dictionary = model.dictionaryRepresentation() {
                dictionaryArray.append(dictionary)
            }
        }
        
        if dictionaryArray.isEmpty == false {
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionaryArray, options: [])
                return data
            } catch {
                //App.logger.debugLog(error)
            }
        }
        
        return nil
    }
    
    static func dataFromInstance(_ model: BaseModel) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: model.dictionaryRepresentation()!,
                                                  options: [])
            return data
        } catch {
            //App.logger.debugLog(error)
        }
        
        return nil
    }
    
    func dictionaryFromStringifiedJson(_ jsonString: Any?) -> [String: Any]? {
        
        if let jsonDict = jsonString as? [String: Any] {
            return jsonDict
        }
        
        guard jsonString as? String != nil else {return nil}
        
        let data = (jsonString as? String)!.data(using: String.Encoding.utf8)
        
        guard data != nil else {
            return nil
        }
        
        var jsonDict: [String: Any]? = nil
        
        do {
            jsonDict =
                try JSONSerialization.jsonObject(with: data!,
                                                 options: .allowFragments) as? [String: Any]
            
        } catch {
            //App.logger.debugLog(error)
        }
        
        return jsonDict
    }
    
    func arrayFromStringifiedJson(_ jsonString: Any?) -> [Any]? {
        
        if let jsonArray = jsonString as? [Any] {
            return jsonArray
        }
        
        guard jsonString as? String != nil else {return nil}
        
        let data = (jsonString as? String)!.data(using: String.Encoding.utf8)
        
        guard data != nil else {
            return nil
        }
        
        var jsonArray: [Any]? = nil
        
        do {
            jsonArray =
                try JSONSerialization.jsonObject(with: data!,
                                                 options: .allowFragments) as? [Any]
            
        } catch {
            //App.logger.debugLog(error)
        }
        
        return jsonArray
    }
    
    func listFromRawArray<T: BaseModel>(_ listArray:[Any]?) -> [T]? {
        if listArray == nil {
            return nil
        }
        
        var itemList = [T]()
        for (element) in listArray! {
            let instance = T.instanceFromDictionary(element as? [String : Any]) as? T
            
            if instance != nil {
                itemList.append(instance!)
            }
        }
        
        return itemList
    }
}
