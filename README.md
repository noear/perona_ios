# perona for ios
perona是一个跨平台的服务启动框架。是服务端版本solon的情侣版，有android版本，有ios版本。<br/>
<br/>
在将客户端的作用是实现组件功能的服务化，进而为大项目的组件化开发，提供一套弱偶合的方案。比如像支付宝那种有N多组件组成的项目...<br/>
<br/>
基于客户端的需要，框架里也支持消息总线功能。用于组件之间的消息分发.<br/>
<br/>
最佳的效果：开发一个动态的框架性主项目，所有组件功能全在服务端进行配置。
<br/>

### perona使用说明

#### 1、相关项目添加引用

`pod 'perona',:git=>"https://github.com/noear/perona_ios.git"`

#### 2、主项目启动服务
```Objective-C
#import <perona/perona.h>  //:不要太纠结大小写的问题：）

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //启动服务（内置了正则路由表 和 HASH路由表，也可以自己定义一个）
    [XApp start:application];
}
```

#### 3、组件项目进行适配（例组件名：module2）
##### 3.1 适配XMoudle接口
```Objective-C
//XModule2.h
@interface XModule2 : NSObject<XModule>

@end

//XModule2.m
@implementation XModule2
-(void)start:(XApp*) app{
    //app.application; //此对象可用

    //注册路由
    [app reg:self expr:@"xapp://module2/xxx" handler:^(XContext*  c) {
        [c output:@"m2"]; //跳转控制器等...业务处理（可以输出结果，或不输出）
    }];
}
@end
```
##### 3.2 添加配置文件 perona.plist （完成组件自发现的配置）
`perona.xmodule = XModule2`

#### 4、主项目引入组module2（内部配置需要自己完成）
`pod 'module2'`

#### 5 调用
##### 5.1 本地代码调用
```Objective-C
//调用功能
////不需要回调的
[XClient call:self url:@"xapp://module2/xxx?id=1" params:nil]; 
////需要回调的
[XClient call:self url:@"xapp://module2/xxx?id=1" params:nil callback:^(XContext* c,id data) {
    NSLog(@"%@", data); 
}];

//分发消息
[XClient send:self url:@"msg://topic/xxx" params:nil];
```
##### 5.2 内嵌WEB调用（需要适配一下WebView）
```html
<a href="xapp://module2/xxx?id=1">xxx</a>
```

# 复杂一点的XModule示例
有助于了解期作用...

```Objective-C

#import "XModuleXxxx.h"
#import "XxxxApp.h"

@implementation XModuleXxxx

- (void)start:(XApp *)app
{
    [app reg:self expr:@"xapp://Xxxx/*" handler:^(XContext * _Nonnull context) {
        
        NSString *p = context.path;
        NSDictionary *params = context.paramMap;
        UIViewController *vc = (UIViewController *)context.requester;
        
        NSString *mobile = params[@"mobile"];
        NSString *ugroupId = params[@"ugroupId"];
        
        if([p isEqualToString:@"/id"]){
            [XxxxApp showIdOcrView:vc mobile:mobile ugroupId:ugroupId completion:^(BOOL success, NSString * message) {
                [context output:@(success)];
            }];
        }
        else if([p isEqualToString:@"/face"]){
            [XxxxApp showFaceLiveView:vc mobile:mobile ugroupId:ugroupId completion:^(BOOL success, NSString * message) {
                [context output:@(success)];
            }];
        }
        else if([p isEqualToString:@"/contacts"]){
            [XxxxApp showContactsView:vc mobile:mobile ugroupId:ugroupId completion:^(BOOL success, NSString * message) {
                [context output:@(success)];
            }];
        }
        else if([p isEqualToString:@"/tele"]){
            [XxxxApp showWebView:vc mobile:mobile ugroupId:ugroupId AuthUrlType:AuthUrlTypeWechash completion:^(BOOL success, NSString * message) {
                [context output:@(success)];
            }];
        }
        else if([p isEqualToString:@"/sesame"]){
            [XxxxApp showWebView:vc mobile:mobile ugroupId:ugroupId AuthUrlType:AuthUrlTypeZmxy completion:^(BOOL success, NSString * message) {
                
                [context output:@(success)];
            }];
        }
    }];
}

@end

```
