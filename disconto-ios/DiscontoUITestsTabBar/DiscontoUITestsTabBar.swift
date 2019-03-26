//
//  DiscontoUITestsTabBar.swift
//  DiscontoUITestsTabBar
//
//  Created by Rostislav on 03.11.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

import XCTest
var app = XCUIApplication()

class DiscontoUITestsTabBar: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
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
    
    func testLogin(){
        sleep(3)
        if app.buttons["fb"].exists {
            app.buttons["fb"].tap()
            sleep(5)
            if app.buttons["OK"].exists {
                app.buttons["OK"].tap()
                sleep(5)
                if app.tabBars.element(boundBy: 0).exists {
                    
                    app.tabBars.buttons["Дисконты"].tap()
                    sleep(3)
                    app.tabBars.buttons["Магазины"].tap()
                    sleep(3)
                    app.tabBars.buttons["Акции"].tap()
                    sleep(3)
                    app.tabBars.buttons["Купоны"].tap()
                    sleep(3)
                    app.tabBars.buttons["Кошелек"].tap()
                    sleep(3)
                     app.tabBars.buttons["Дисконты"].tap()
                }
            }
        }else if app.tabBars.element(boundBy: 0).exists {
            
            self.goSendDisconto()
        }
        
    }
    
    func goSendDisconto(){
    
        if app.tables.element(boundBy: 0).exists {
            app.tables.element(boundBy: 0).cells.staticTexts["Все дисконты"].tap()
            sleep(3)
            app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
            sleep(3)
           // app.buttons["like"].tap()
            if app.buttons["Разблокировать дисконт"].exists {
                
                app.buttons["Разблокировать дисконт"].tap()
                sleep(3)
                if app.tables.element(boundBy: 0).exists {
                    
                    app.tables.element(boundBy: 0).buttons.element(boundBy: 0).tap()
                    
                    sleep(3)
                    if app.buttons["Готово"].exists {
                    
                        app.buttons["Готово"].tap()
                    }
                    sleep(3)
                    self.goToCamera()
                }
            }else {
            
                self.goToCamera()
            }
        }
    }
    
    func goToCamera(){
    
        sleep(3)
        if app.buttons["Перейти к фото чека"].exists{
            
            app.buttons["Перейти к фото чека"].tap()
            sleep(3)
            if app.navigationBars.element(boundBy: 0).identifier == "Магазины" {
            
                if app.cells.count > 0 {
                
                    app.cells.element(boundBy: 0).tap()
                    sleep(3)
                    
                    var i = 0
                    while i < 20 {
                        
                        if app.cells.count == 1 {
                            
                            app.buttons["+"].tap()
                            i += 1
                        }
                    }
                    i = 0
                    while i < 10 {
                        
                        if app.cells.count == 1 {
                            
                            app.buttons["-"].tap()
                            i += 1
                        }
                    }
                    sleep(3)
                    if app.buttons["Сделать фото чека"].exists {
                        
                        app.buttons["Сделать фото чека"].tap()
                        sleep(3)
                        if app.buttons["Далее"].exists {
                        
                            app.buttons["Далее"].tap()
                            sleep(3)
                            app.buttons["Галерея"].tap()
                            if app.cells["Снимки экрана"].exists {
                                
                                app.cells["Снимки экрана"].tap()
                                sleep(2)
                                app.cells.element(boundBy: 0).tap()
                                sleep(2)
                                app.buttons["delete"].tap()
                                sleep(2)
                                app.buttons["Удалить"].tap()
                                sleep(2)
                           //     app.buttons["addPhoto"].tap()
                            //    sleep(2)
                                app.buttons["takePhoto"].tap()
                                sleep(2)
                                app.buttons["seand"].tap()
                                sleep(10)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}
