//
//  ContainerSpec.Config.swift
//  Swinject-iOS
//
//  Created by Oliver Siedler on 06.07.19.
//  Copyright © 2019 Swinject Contributors. All rights reserved.
//
// swiftlint:disable type_body_length
// swiftlint:disable function_body_length

import Quick
import Nimble
//@testable import Swinject


class ContainerSpec_Config: QuickSpec {
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
        }
        
        describe("Resolution of a Config file") {
            it("Resolve configured type") {
                do {
                    let url = Bundle(for: type(of: self)).url(forResource: "Config", withExtension: "json")
                    
                    try container.registerConfig(url!)
                    
                    let car = container.resolveConfig(Car.self, "Car")
                    expect(car.driver.test) == "Driver"
                } catch {
                    fail("Container failed")
                }
            }
            it("Register not existing file") {
                let notExistingUrl = URL(fileURLWithPath: "Not/A/Path/NotAFile.NotAExt")
                
                expect { try container.registerConfig(notExistingUrl) }.to(throwError())
            }
        }
    }
}
