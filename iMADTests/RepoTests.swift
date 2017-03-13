//
//  RepoTests.swift
//  iMAD
//
//  Created by hendi on 13/03/17.
//  Copyright © 2017 cuca. All rights reserved.
//

import XCTest
import Alamofire
import Gloss

@testable import iMAD

class RepoTests: XCTestCase {
    
    var repos:[Repo] = []
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
//        let exp = expectation(description: "\(#function)\(#line)")
        
        let urlString = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(1)"
        
        Alamofire.request(urlString).responseJSON { response in
            
            if let value = response.result.value {
                
                let json = value as! Dictionary<String, Any>
                let items = json["items"]
                
                for item in items as! Array<Any> {
                    
                    if let repo = Repo(json:item as! JSON) {
                        self.repos.append(repo)
                    }
                }
            }
        }
//        waitForExpectations(timeout: 40, handler: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.repos.removeAll()
    }
    
    func testIfRepoAlwaysHaveAnOwner() {
        
        XCTAssert(self.repos.count > 0, "repos array is empty")
    }

    
}
