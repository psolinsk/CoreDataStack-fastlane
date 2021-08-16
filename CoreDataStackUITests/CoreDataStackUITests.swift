//
//  CoreDataStackUITests.swift
//  CoreDataStackUITests
//
//  Created by Grzegorz Kwasniewski on 02/06/2018.
//  Copyright © 2018 Grzegorz Kwasniewski. All rights reserved.
//

import XCTest

class CoreDataStackUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        
        let addButton = XCUIApplication().navigationBars["MainVC"].buttons["Add"]
            addButton.tap()
            addButton.tap()
        
        snapshot("MainScreen")
        
        let tablesQuery = app.tables
            tablesQuery.cells.containing(.staticText, identifier:"1").staticTexts["New user"].tap()
               
        let userSnacksNavigationBar = app.navigationBars["User Snacks"]
        let addButtonSnacks = userSnacksNavigationBar.buttons["Add"]
            addButtonSnacks.tap()
            addButtonSnacks.tap()
            addButtonSnacks.tap()
            addButtonSnacks.tap()
        
        snapshot("FirstUserSnacks")
               
        let mainvcButton = userSnacksNavigationBar.buttons["MainVC"]
            mainvcButton.tap()
            tablesQuery.cells.containing(.staticText, identifier:"2").staticTexts["New user"].tap()
            addButtonSnacks.tap()
            addButtonSnacks.tap()
        
        snapshot("SecondUserSnacks")
        
            mainvcButton.tap()
    }
}
