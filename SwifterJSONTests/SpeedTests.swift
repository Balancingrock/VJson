//
//  SpeedTests.swift
//  SwifterJSON
//
//  Created by Marinus van der Lugt on 10/03/16.
//  Copyright © 2016 Marinus van der Lugt. All rights reserved.
//

import XCTest

class SpeedTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    static let data1Str = "{}"
    static let data2Str = "{\"top\":[{\"object\":{\"array\":[[null],true]}},false]}"
    static let data3Str = "{\"top\":12,\"name\":\"test\",\"name\":\"test\",\"name\":\"test\",\"name\":\"test\"}"
    static let data4Str = "{\"array\":[12,23,34,45,56,67,78,89,90]}"
    static let data5Str = "{\"array\":[\"a1\",\"a2\",\"a3\",\"a4\",\"a5\",\"a6\",\"a7\",\"a8\",\"a9\",\"a0\",\"a\"]}"
    
    static let data1 = data1Str.dataUsingEncoding(NSUTF8StringEncoding)!
    static let data2 = data2Str.dataUsingEncoding(NSUTF8StringEncoding)!
    static let data3 = data3Str.dataUsingEncoding(NSUTF8StringEncoding)!
    static let data4 = data4Str.dataUsingEncoding(NSUTF8StringEncoding)!
    static let data5 = data5Str.dataUsingEncoding(NSUTF8StringEncoding)!

    func testAppleJSONPerformance1() {

        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try NSJSONSerialization.JSONObjectWithData(SpeedTests.data1, options: NSJSONReadingOptions())
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testVJSONPerformance1() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try VJson.parse(UnsafePointer<UInt8>(SpeedTests.data1.bytes), numberOfBytes: SpeedTests.data1.length)
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testAppleJSONPerformance2() {

        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try NSJSONSerialization.JSONObjectWithData(SpeedTests.data2, options: NSJSONReadingOptions())
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testVJSONPerformance2() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try VJson.parse(UnsafePointer<UInt8>(SpeedTests.data2.bytes), numberOfBytes: SpeedTests.data2.length)
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testAppleJSONPerformance3() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try NSJSONSerialization.JSONObjectWithData(SpeedTests.data3, options: NSJSONReadingOptions())
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testVJSONPerformance3() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try VJson.parse(UnsafePointer<UInt8>(SpeedTests.data3.bytes), numberOfBytes: SpeedTests.data3.length)
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }

    
    func testAppleJSONPerformance4() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try NSJSONSerialization.JSONObjectWithData(SpeedTests.data4, options: NSJSONReadingOptions())
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    
    func testVJSONPerformance4() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try VJson.parse(UnsafePointer<UInt8>(SpeedTests.data4.bytes), numberOfBytes: SpeedTests.data4.length)
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }


    func testAppleJSONPerformance5() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try NSJSONSerialization.JSONObjectWithData(SpeedTests.data5, options: NSJSONReadingOptions())
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    
    func testVJSONPerformance5() {
        
        self.measureBlock {
            do {
                for _ in 1 ... 1000 {
                    _ = try VJson.parse(UnsafePointer<UInt8>(SpeedTests.data5.bytes), numberOfBytes: SpeedTests.data5.length)
                }
            } catch let error as NSError {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
