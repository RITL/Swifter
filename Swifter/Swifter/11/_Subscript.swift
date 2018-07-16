//
//  11.swift
//  Swifter
//
//  Created by YueWen on 2018/7/16.
//  Copyright © 2018年 YueWen. All rights reserved.
//

import Foundation

extension Array {
    subscript(input: [Int]) -> ArraySlice<Element>{
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count,"Index out of range")
                result.append(self[i])
            }
            return result
        }
        
        set {
            for (index,i) in input.enumerated() {
                assert(i < self.count,"index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

