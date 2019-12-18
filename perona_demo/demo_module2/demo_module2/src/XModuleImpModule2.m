//
//  XModuleImpModule2.m
//  demo_module2
//
//  Created by 谢月甲 on 2018/10/9.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XModuleImpModule2.h"

@implementation XModuleImpModule2
-(void)start:(XApp*) app{
    
    
    //app.application;
    
    [app reg:self expr:@"xapp://x/m2" handler:^(XContext * _Nonnull cxt) {
        NSLog(@"参数：a=%@", cxt.paramMap[@"a"]);
        [cxt output:@"m2"];
    }];
    
    //[app unreg:self expr:@"xapp://x/m2"];
    
    [app reg:self expr:@"msg://x/*" handler:^(XContext * _Nonnull cxt) {
        NSString* p = cxt.path;
        
        if([p isEqualToString:@"user"]){
            
        }
        
        if([p isEqualToString:@"order"]){
            
        }
    }];
    
    //[XClient call:self url:@"msg://x/user" params:nil];
    //[XClient call:self url:@"msg://x/order" params:nil];
}
@end
