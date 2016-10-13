//
//  BulbManager.swift
//  LIFX
//
//  Created by Aladin TALEB on 14/04/16.
//  Copyright © 2016 Aladin. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import Gloss

enum LIFXApi : String {
  case GetLights = ""
  case SetState = "/state"
}

enum LIFXSelector {
  case All
  case Label([String])
  case Id([String])
  
  func stringValue() -> String {
    switch self {
    case All:
      return "all"
    case Label(let selectors):
      return stringListFrom(selectors, prefix: "label:")
    case Id(let selectors):
      return "id:" + stringListFrom(selectors, prefix: "id:")
    }
  }
}

class BulbManager {
  
  //MARK: VAR
  static let sharedManager = BulbManager()
  let duration = 0.75

  let lifxAddress = "https://api.lifx.com/v1/lights/"
  
  let headers = [
    "Authorization" : "Bearer xxx"
  ]
  
  //MARK: Rest Request
  func requestREST(
    method: Alamofire.Method,
    selectors: LIFXSelector,
    _ api: LIFXApi,
      parameters: [String: AnyObject]? = nil,
      encoding: ParameterEncoding = .URL)
    -> Promise<AnyObject>
  {
    return Promise { fulfill, reject in
      Alamofire
        .request(method, lifxAddress + selectors.stringValue() + api.rawValue, parameters: parameters, encoding:  encoding, headers: headers)
        .responseJSON { response in
          switch response.result {
            
          /////////////////////
          case .Success(let dic):
            //-------------------
            print(dic)
            fulfill(dic)
            
          /////////////////////
          case .Failure(let error):
            //-------------------
            reject(error)
          }
      }
    }
  }
  
  //MARK: Getter
  func getLights() -> Promise<[Bulb]> {
    return Promise { fulfill, reject -> Void in
      
      requestREST(.GET, selectors: .All, .GetLights, parameters: nil)
        .then {data -> Void in
          
          if data is [JSON] {
            let bulbs = [Bulb].fromJSONArray(data as! [JSON])
            fulfill(bulbs)
          } else {
            reject(NSError(domain: "Invalid Data", code: 0, userInfo: nil))
          }
          
        }.error {error in
          reject(error)
      }
    }
  }
  
  
  //MARK: Setter
  //Set Power
  func setForBulb(bulb: Bulb, power aPower: Bool) -> Promise<Void> {
    return Promise { fulfill, reject -> Void in
      requestREST(.PUT, selectors: .All, .SetState, parameters: ["power": aPower == true ? "on" : "off", "duration": duration])
        .then {_ -> Void in
          fulfill()
        }.error {error in
          reject(error)
      }
    }
  }
  
  //Set Brightness
  func setForBulb(bulb: Bulb, brightness aBrightness: Double) -> Promise<Void> {
    return Promise { fulfill, reject -> Void in
      requestREST(.PUT, selectors: .All, .SetState, parameters: ["brightness": aBrightness, "duration": duration])
        .then {_ -> Void in
          fulfill()
        }.error {error in
          reject(error)
      }
    }
  }
  
  //Set Hue
  func setForBulb(bulb: Bulb, hue aHue: Double) -> Promise<Void> {
    return Promise { fulfill, reject -> Void in
      requestREST(.PUT, selectors: .All, .SetState, parameters: ["color": "hue:" + String(round(aHue*360)) + " saturation:1.0", "duration" : duration])
        .then {_ -> Void in
          fulfill()
        }.error {error in
          reject(error)
      }
    }
  }
  
  //Set Temperature in Kelvin
  func setForBulb(bulb: Bulb, kelvin aKelvin: Int) -> Promise<Void> {
    return Promise { fulfill, reject -> Void in
      requestREST(.PUT, selectors: .All, .SetState, parameters: ["color": "kelvin:" + String(aKelvin) + " saturation:0.0", "duration" : duration])
        .then {_ -> Void in
          fulfill()
        }.error {error in
          reject(error)
      }
    }
  }
  
}