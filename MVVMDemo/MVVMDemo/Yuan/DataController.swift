//
//  DataController.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/21.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import Foundation

class DataController {
    var sections: Array<HomeSection> = []
    func getData(_ block: @escaping EmptyBlock) {
        gankApi.request(GankAPI.data(type: GankType.mapCategory(with: 0), size: 20, index: 0)) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.mapArray(Brick.self)
                    self.sections = [HomeSection(items: data)]
                } catch {
                    self.sections = []
                }
                block()
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
