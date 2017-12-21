//
//  DataBindLoginModel.swift
//  MVVMDemo
//
//  Created by 乔羽 on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import Foundation

// 1.定义一个可绑定类型
class Obserable<T>{
    // 定义一个 Block
    typealias ObserableType = (T) -> Void
    var value:T {
        didSet {
            observer?(value) // block 调用
        }
    }
    // 声明一个 Block 变量
    var observer:(ObserableType)?
    // 绑定数据
    func bind(to observer:@escaping ObserableType) {
        self.observer = observer
        observer(value) // block 调用
    }
    init(value:T) {
        self.value = value
    }
}


class DataBindLoginModel {
    var username: Obserable<String>
    var passwd: Obserable<String>
    init(username: String, passwd: String) {
        self.username = Obserable(value: username)
        self.passwd = Obserable(value: passwd)
    }
}
