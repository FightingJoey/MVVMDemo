//
//  SimpleMVVMViewModel.swift
//  MVVMDemo
//
//  Created by Geselle-Joy on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

typealias GankType = GankAPI.GankCategory

public typealias EmptyBlock = (() -> ())

public typealias PushBlock = ((UIViewController) -> ())

class SimpleMVVMViewModel {
    
    var pushBlock: PushBlock!
    
    var sections: Array<HomeSection> = []
    
    let reloadBlock: EmptyBlock
    
    let isRefresh: Obserable<Bool>
    
    init(block: @escaping EmptyBlock) {
        self.isRefresh = Obserable(value: false)
        
        reloadBlock = block
    }
    
    init(block: @escaping EmptyBlock, push: @escaping PushBlock) {
        self.isRefresh = Obserable(value: false)
        
        reloadBlock = block
        pushBlock = push
    }
    
    func getData() {
        gankApi.provider.request(GankAPI.data(type: GankType.mapCategory(with: 0), size: 20, index: 0)) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.mapArray(Brick.self)
                    self.sections = [HomeSection(items: data)]
                } catch {
                    self.sections = []
                }
                self.isRefresh.value = true
//                self.reloadBlock()
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    func selectCell(_ section: Int, _ row: Int, controller: UIViewController) {
        let url = sections[section].items[row].url
        let webActivity = BrowserWebViewController(url: URL(string: url)!)
        controller.push(webActivity)
    }
    
    func selectCell(_ section: Int, _ row: Int) {
        let url = sections[section].items[row].url
        let webActivity = BrowserWebViewController(url: URL(string: url)!)
        pushBlock(webActivity)
    }
}
