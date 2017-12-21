# MVVMDemo
记录了我对`MVVM`架构的一些理解及成长。

----

一开始进行开发的时候，都是采用`MVC`的架构。

在`iOS`开发中，`UIViewController`是一个相当重要的角色，它是一个个界面的容器，负责接收各类系统的事件，能够实现界面转场的各种效果，配合`NavigationController`等能够轻易的实现各类界面切换。在实践中，我们发现`UIViewController`和`View`往往是绑定在一起的，比如`UIViewController`的一个属性就是`view`。

所以在`iOS`中，`UIViewController`在很多时候既包含了`View`，又包含了`Controller`，随着项目的不断迭代，`UIViewController`里的各种业务逻辑，数据逻辑，页面跳转逻辑等等越来越多，导致`UIViewController`越来越难以维护，成为了人们所说的 `Massive View Controller`(重量级视图控制器)。


在纯粹的`MVC`设计模式中，`Controller`不得不承担大量的工作：

- 网络 API 请求
- 数据读写
- 日志统计
- 数据的处理（JSON<=>Object，数据计算）
- 对 View 进行布局，动画
- 处理 Controller 之间的跳转（ push/modal/custom ）
- 处理 View 层传来的事件，返回到 Model 层

----

这个时候，我想着给`ViewController`瘦身，于是开始接触了`MVVM`架构，在这个时候的理解，引入`MVVM`就是为了把大量原来放在` ViewController `里的视图逻辑和数据逻辑移到` ViewModel `里，从而有效的减轻` ViewController `的负担，以便以后的项目维护。

在MVVM中，`UIViewController`可以当作一个重量级的`View`（负责界面切换和处理各类系统事件），而原来`Controller`里的各种逻辑，放到`ViewModel`里去处理。

> 有人会问：把所有的逻辑都放在`ViewModel`里，不也会造成`ViewModel`变得臃肿，难以维护吗？

> `ViewModel`可以进行拆分，每个`View`可以对应一个`ViewModel`。

----

后来又了解到，`MVVM `通常还会和一个强大的绑定机制一同工作，一旦` ViewModel `所对应的 `Model `发生变化时，`ViewModel `的属性也会发生变化，而相对应的` View `也随即产生变化。

----

然后在看文章的时候看到了猿题库 iOS 客户端架构设计，觉得写得也非常好，也实践了一下。

**觉得有帮助的给个`Star`哦**

## MVVM详解
在`MVVM`设计模式中，组件变成了`Model-View-ViewModel`。

`MVVM`有两个规则

- **View持有ViewModel的引用，反之没有**
- **ViewModel持有Model的引用，反之没有**

<img src="http://img.blog.csdn.net/20170517103440413?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvSGVsbG9fSHdj/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast">

图中，我们以**实线表示持有，虚线表示盲通信**。

那么，何为**盲通信**呢？简单来说当消息的发送者不知道接受者详细信息的时候，这样的通信就是盲通信。`Cocoa Touch`为我们提供了诸如**delegate(dataSource)**，**block**，**target/action**这些盲通信方式。

对于一个界面来说，有时候`View`和`ViewModel`往往不止一个，`MVVM`也可以组合使用：

<img src="http://img.blog.csdn.net/20170517141356307?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvSGVsbG9fSHdj/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast">

### ViewModel的哲学
- `View `不应该存在逻辑控制流的逻辑，`View `不应该对数据造成操作，`View `只能绑定数据，控制显示。
- `View `并不知道` ViewModel `具体做了什么，`View `只能通过` ViewModel `知道需要` View `做什么。
- `Model` 应当被` ViewModel `所隐藏，`ViewModel`只暴露出`View`渲染所需要的最少信息。

### MVVM双向绑定
- **`Model—>View`：**`Model `变化时，`ViewModel `会自动更新，而` ViewModel `变化时，`View `也会自动变化。这种流向很简单，你请求数据之后，通过` Block `的回调，最终更新`UI`。
- **`View—>Model`：**`View`触发事件，更新对面`ViewModel`里面绑定的数据源，例如登录注册的`Textfield`，你输入和删除的时候，你的`Model`字段会对应更新，当你提交的时候，读取`ViewModel`的字段，就是已经更新的最新数据。

### 数据单向绑定
```
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
// 2.我们扩展UILabel，让其text能够绑定到某一个Obserable值上
extension UILabel{
    var ob_text:Obserable<String>.ObserableType {
        return { value in
            self.text = value
        }
    }
}
// 3.建立一个ViewModel
class MyViewModel{
    var labelText:Obserable<String>
    init(text: String) {
        self.labelText = Obserable(value: text)
    }
}
```

实现数据单向绑定

```
let label = UILabel()
label.frame = CGRect(x: 100, y: 100, width: 200, height: 44)
self.view.addSubview(label)
        
// 4.单向绑定
vm = MyViewModel(text: "Inital Text")
//修改viewModel会自动同步到Label
vm.labelText.bind(to: label.o
```

## 参考文章
在学习实践的过程中，看了很多前辈的文章，以下是我觉得写得非常好的几篇，我文中的一些内容也是从他们文章摘取的。

- [猿题库 iOS 客户端架构设计](http://gracelancy.com/blog/2016/01/06/ape-ios-arch-design/)
- [MVVM于Controller瘦身实践](https://github.com/LeoMobileDeveloper/Blogs/blob/master/iOS/MVVM%20and%20Controller%20thin.md)
- [从项目实践走向RxSwift响应式函数编程](http://www.jianshu.com/p/de7e90e1c13d)


