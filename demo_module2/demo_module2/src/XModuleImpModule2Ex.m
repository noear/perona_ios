//
//  XModuleImpModule2Ex.m
//  demo_module2
//
//  Created by 谢月甲 on 2018/10/10.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XModuleImpModule2Ex.h"

@interface XModuleImpModule2Ex (){
    id<XRouter> _routerList;
}

-(void)handle:(XContext*) cxt;

@end

@implementation XModuleImpModule2Ex

- (instancetype)init
{
    self = [super init];
    if (self) {
        _routerList = [[XRouterMap alloc] init];
    }
    return self;
}

-(void)start:(XApp*) app{
    [app reg:self expr:@"xapp://x/m2" handler:^(XContext * _Nonnull cxt) {
        [self handle:cxt];
    }];
    
    
    [_routerList add:self expr:@"/user/list" target:^(XContext * _Nonnull context) {
        
    }];
    
    [_routerList add:self expr:@"/user/info" target:^(XContext * _Nonnull context) {
        
    }];
}

-(void)handle:(XContext*) cxt{
    NSString* path = cxt.path;
    
    XHandler handler = [_routerList match:path];
    
    if(handler != nil){
        handler(cxt);
        [cxt setHandled:TRUE];
    }
}

@end
