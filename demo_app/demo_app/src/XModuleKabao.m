//
//  XModuleKabao.m
//  demo_app
//
//  Created by 谢月甲 on 2018/10/15.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XModuleKabao.h"

@implementation XModuleKabao

- (void)start:(XApp *)app{
    [app reg:self expr:@"kabao51://code/*" handler:^(XContext * _Nonnull c) {
        NSInteger code = [c.path integerValue];
        
        switch (code) {
            case 1001:break;
            case 1002:break;
            default:break;
        }
        
    }];
}

@end
