//
//  CircularBufferTests.swift
//  CircularBufferTests
//
//  Created by Tomasz Piekarczyk on 29/11/14.
//  Copyright (c) 2014 Tomasz Piekarczyk. MIT License.
//

import UIKit
import XCTest

class CircularBufferTests: XCTestCase {
    
    func testPrintable() {

        let buffer = CircularBuffer(array: [1,2])
        XCTAssertEqual(buffer.description,"1,2")
    }
    
    
    func testCount() {
        
        let buffer = CircularBuffer(array: [1,2])
        
        XCTAssert(buffer.count == 2)
        
    }
    
    
    func testEnumerationIterations() {
        
        let array = [1,2]
        let buffer = CircularBuffer(array: array)
        var count = 0
        
        for object in buffer {
            
            XCTAssert(object == array[count])
            ++count
        }
        
        XCTAssert(count == buffer.count)
    }
    

    func testReadingFromEmpty() {
        
        var buffer = CircularBuffer<Int>(size:2)
        let object = buffer.readNext()
        
        XCTAssertNil(object)
        
    }
    

    func testReadingFromNonEmpty() {
        
        var buffer = CircularBuffer(array:[2])
        let object = buffer.readNext()
        
        XCTAssert(object == 2)
        XCTAssert(buffer.asArray().count == 0)
    }
    
    
    func testWriting() {
        
        var buffer = CircularBuffer<Int>(size: 2)
        XCTAssert(buffer.asArray().count == 0)
        
        buffer.writeNext(10)
        XCTAssert(buffer.asArray().count == 1)
        
        let stored = buffer.readNext()!
        XCTAssert(stored == 10)
        
    }
    
    
    func testWritingCircularity() {
    
        var buffer = CircularBuffer<Int>(array: [1,2,3])
        
        buffer.writeNext(4)
        buffer.writeNext(5)
        buffer.writeNext(6)
        buffer.writeNext(7)
        buffer.writeNext(8)
        
        let array = [6,7,8] // - 6 is eldest in the buffer
        
        for idx in 0..<buffer.size {
            
            XCTAssert(array[idx] == buffer.readNext()!)
        }
    }
    
    
    func testOverwritingElementsMovesTheEldestElement() {
    
        var buffer = CircularBuffer(array: [1,2])
        buffer.writeNext(3)
        
        XCTAssert(buffer.readNext()! == 2)
        
    }
    
    
    func testExhaustiveReading() {

        var buffer = CircularBuffer<Int>(array: [1,2])
        
        XCTAssert(buffer.readNext()! == 1)
        XCTAssert(buffer.readNext()! == 2)
        XCTAssert(buffer.readNext() == nil)
        XCTAssert(buffer.readNext() == nil)
        
    }

    func testAlternateReadingAndWriting() {
        
        var buffer = CircularBuffer<Int>(array: [1,2])
        
        XCTAssert(buffer.readNext()! == 1)
        buffer.writeNext(3)
        XCTAssert(buffer.readNext()! == 2)
        buffer.writeNext(4)
        XCTAssert(buffer.readNext()! == 3)
        XCTAssert(buffer.readNext()! == 4)
        XCTAssert(buffer.readNext() == nil)
        
    }
    
    func testArrayConvertible() {
        
        var buffer: CircularBuffer<Int> = [1,2]
        
        XCTAssert(buffer.readNext()! == 1)
        XCTAssert(buffer.readNext()! == 2)
        XCTAssert(buffer.readNext() == nil)
        
    }
    
}
