//
//  DataBindLoginViewModel.swift
//  MVVMDemo
//
//  Created by 乔羽 on 2017/12/20.
//  Copyright © 2017年 zhengtou. All rights reserved.
//

import UIKit

/*
 ViewModel的哲学
 
 - View 不应该存在逻辑控制流的逻辑，View 不应该对数据造成操作，View 只能绑定数据，控制显示。
 - View 并不知道 ViewModel 具体做了什么，View 只能通过 ViewModel 知道需要 View 做什么。
 - Model 应当被 ViewModel 所隐藏，ViewModel 只暴露出 View 渲染所需要的最少信息。
 
 
 MVVM双向绑定
 
 - Model—>View：Model变化时，ViewModel会自动更新，而ViewModel变化时，View也会自动变化。这种流向很简单，你请求数据之后，通过Block的回调，最终更新UI。
 - View—>Model：View触发事件，更新对面ViewModel里面绑定的数据源，例如登录注册的Textfield，你输入和删除的时候，你的Model字段会对应更新，当你提交的时候，读取ViewModel的字段，就是已经更新的最新数据。
 */

class DataBindLoginViewModel {
    var model: DataBindLoginModel!
    var usernamePromptIsHidden: Obserable<Bool>
    var passwdPromptIsHidden: Obserable<Bool>
    var btnIsEnabled: Obserable<Bool>
    
    var ob_usernamePromptIsHidden:Obserable<String>.ObserableType {
        return { value in
            if value.count >= 6 {
                self.usernamePromptIsHidden.value = true
            } else {
                self.usernamePromptIsHidden.value = false
            }
            if self.passwdPromptIsHidden.value && self.usernamePromptIsHidden.value {
                self.btnIsEnabled.value = true
            } else {
                self.btnIsEnabled.value = false
            }
        }
    }
    
    var ob_passwdPromptIsHidden:Obserable<String>.ObserableType {
        return { value in
            if value.count >= 6 {
                self.passwdPromptIsHidden.value = true
            } else {
                self.passwdPromptIsHidden.value = false
            }
            if self.passwdPromptIsHidden.value && self.usernamePromptIsHidden.value {
                self.btnIsEnabled.value = true
            } else {
                self.btnIsEnabled.value = false
            }
        }
    }
    
    init() {
        self.usernamePromptIsHidden = Obserable(value: false)
        self.passwdPromptIsHidden = Obserable(value: false)
        self.btnIsEnabled = Obserable(value: false)
        
        self.model = DataBindLoginModel(username: "", passwd: "")
        self.model.username.bind(to: self.ob_usernamePromptIsHidden)
        self.model.passwd.bind(to: self.ob_passwdPromptIsHidden)
    }
    
    func usernameChange(_ username: String) {
        self.model.username.value = username
    }
    func passwdChange(_ passwd: String) {
        self.model.passwd.value = passwd
    }
}
