//
//  BeaconStoreTests.swift
//  mobileFramework
//
//  Created by Peter.Alt on 4/20/17.
//  Copyright © 2017 Philadelphia Museum of Art. All rights reserved.
//

import XCTest

class BeaconStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_add_beacon() {
        let store = BeaconStore()
        
        let sampleUUID = UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
        let sampleBeacon = Beacon(major: 1111, minor: 2222, UUID: sampleUUID!)
        
        XCTAssertEqual(0, store.beacons.count)
        
        store.add(beacon: sampleBeacon)
        
        XCTAssertEqual(1, store.beacons.count)
    }
    
    func test_is_beacon_known() {
        
        let store = BeaconStore()
        
        let sampleUUID = UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
        let sampleBeacon = Beacon(major: 1111, minor: 2222, UUID: sampleUUID!)
        
        store.add(beacon: sampleBeacon)
        
        let resultKnown = store.isKnown(major: 1111, minor: 2222, UUID: sampleUUID!)
        let resultUnknown = store.isKnown(major: 333, minor: 2222, UUID: sampleUUID!)
        
        XCTAssertTrue(resultKnown)
        XCTAssertFalse(resultUnknown)
        
    }
    
    func test_add_beacon_in_range() {
        
        let store = BeaconStore()
        
        let sampleUUID = UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
        let sampleBeacon = Beacon(major: 1111, minor: 2222, UUID: sampleUUID!)
        
        store.add(beacon: sampleBeacon)
        
        store.markInRange(major: 1111, minor: 2222, UUID: sampleUUID!)
        
        XCTAssertEqual(1, store.beaconsInRange.count)
        
    }
    
    func test_get_closest_beacon_in_range() {
        
        let store = BeaconStore()
        
        let sampleUUID = UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
        let sampleBeaconA = Beacon(major: 1111, minor: 2222, UUID: sampleUUID!)
        let sampleBeaconB = Beacon(major: 2222, minor: 3333, UUID: sampleUUID!)
        let sampleBeaconC = Beacon(major: 3333, minor: 4444, UUID: sampleUUID!)
        
        store.add(beacon: sampleBeaconA)
        store.add(beacon: sampleBeaconB)
        store.add(beacon: sampleBeaconC)
        
        store.markInRange(major: sampleBeaconA.major, minor: sampleBeaconA.minor, UUID: sampleUUID!)
        store.markInRange(major: sampleBeaconA.major, minor: sampleBeaconA.minor, UUID: sampleUUID!)
        store.markInRange(major: sampleBeaconB.major, minor: sampleBeaconB.minor, UUID: sampleUUID!)
        store.markInRange(major: sampleBeaconC.major, minor: sampleBeaconC.minor, UUID: sampleUUID!)
        
        XCTAssertEqual(sampleBeaconA, store.closestBeacon)
        
        
    }
    
    func test_get_no_closest_beacon_in_range_when_undecided() {
        
        let store = BeaconStore()
        
        let sampleUUID = UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
        let sampleBeaconA = Beacon(major: 1111, minor: 2222, UUID: sampleUUID!)
        let sampleBeaconB = Beacon(major: 2222, minor: 3333, UUID: sampleUUID!)
        let sampleBeaconC = Beacon(major: 3333, minor: 4444, UUID: sampleUUID!)
        
        store.add(beacon: sampleBeaconA)
        store.add(beacon: sampleBeaconB)
        store.add(beacon: sampleBeaconC)
        
        store.markInRange(major: sampleBeaconA.major, minor: sampleBeaconA.minor, UUID: sampleUUID!)
        store.markInRange(major: sampleBeaconB.major, minor: sampleBeaconB.minor, UUID: sampleUUID!)
        store.markInRange(major: sampleBeaconC.major, minor: sampleBeaconC.minor, UUID: sampleUUID!)
        
        XCTAssertEqual(nil, store.closestBeacon)
        
        
    }
    
    
    
}
