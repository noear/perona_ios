//
//  XModuleKbx.m
//  demo_app
//
//  Created by noear on 2018/10/15.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XModuleKbx.h"

@implementation XModuleKbx

- (void)start:(XApp *)app{
    [app reg:self expr:@"kbx://code/*" handler:^(XContext * c) {
        return c.path;
        
    }];
}

@end
