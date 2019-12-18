//
//  AppDelegate.m
//  demo_app
//
//  Created by 谢月甲 on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import "AppDelegate.h"
#import <perona/perona.h>

#import "XModuleKabao.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //启动服务（内置了正则路由 和 HASH路由，也可以自己定义一个）
    [XApp start:application init]];
    
    
    //添加一些自建的模块
    [[XApp global] addModule:[[XModuleKabao alloc] init]];
    
    //测试效果
//    [XClient call:self url:@"xapp://x/m2?a=1" params:nil callback:^(id  _Nonnull data) {
//        NSLog(@"%@", data);
//    }];
//
//    [XClient call:self url:@"xapp://x/m2" params:nil];
//
//    [XClient send:self url:@"msg://x/m2" params:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
