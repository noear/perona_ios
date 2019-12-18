//
//  XApp.m
//  perona
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import "XApp.h"
#import "XUtil.h"
#import "XContext.h"
#import <objc/runtime.h>

static id _global = nil;

/** 通用应用（同时是个通用代理） */
@interface XApp (){
    NSMutableDictionary* _modules;
    XRouter* _router; /** 路由器 */
    UIApplication* _application;
    NSMutableDictionary* _params;
}
-(instancetype)initWith:(UIApplication*)application params:(nullable NSDictionary*)params;
/** 自动加载模块 */
-(void)loadModules;
-(void)do_execute:(XContext *)context handler:(XHandler*)handler;

@end

/** 通用应用（同时是个通用代理） */
@implementation XApp

+(XApp*)global{
    return _global;
}

+(instancetype)start:(UIApplication*)application{
    return [self start:application params:nil];
}

+(instancetype)start:(UIApplication*)application params:(nullable NSDictionary*)params{
    if(_global == nil){
        _global =  [[XApp alloc] initWith:application params:params];
    
        //加载组件
        @try {

#ifdef DEBUG
            CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
            [_global loadModules];
            CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);

            NSLog(@"loadModules: %f ms",linkTime * 1000.0f);
#else
            [_global loadModules];
#endif
            
        } @catch (NSException* ex) {
            NSLog(@"%@", ex);
        }
    }
    
    return _global;
}

-(instancetype)initWith:(UIApplication*)application params:(nullable NSDictionary*)params{
    _router = [[XRouter alloc] init];
    _modules = [NSMutableDictionary dictionary];
    _application = application;
    _params = [NSMutableDictionary dictionary];
    
    if(params){
        [_params addEntriesFromDictionary:params];
    }
    
    return self;
}

- (NSArray<NSString *> *)searchProtocolIMPClass {
    NSMutableArray<NSString *> *impClasses = [NSMutableArray arrayWithCapacity:20];
    
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL,0);
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        Protocol *targetProtocol = objc_getProtocol("XModule");
        
        for (int i = 0; i < numClasses; i++) {
            Class currentClass = classes[i];
            
            if(class_conformsToProtocol(currentClass,targetProtocol)) {
                [impClasses addObject:NSStringFromClass(currentClass)];
                continue;
            }
        }
        
        free(classes);
    }
    
    return impClasses;
}

- (void)loadModules {
    NSArray<NSString *> *impNameArray = [self searchProtocolIMPClass];
    
    for (NSString *impName in impNameArray) {
        id<XModule> module = (id<XModule>)[XUtil newClass:impName];
        [self addModule:module];
    }
}

-(UIApplication*)application{
    return _application;
}
-(BOOL)paramHas:(NSString*)key{
    return [_params.allKeys containsObject:key];
}

-(id)paramGet:(NSString*)key{
    return _params[key];
}
    
/** 手动添加模块 */
-(void)addModule:(NSObject<XModule> *)module{
    if(module != nil){
        Class clz = [module class];
        
        if([_modules.allKeys containsObject:clz] == false){
            [module start:self]; //xmobj is XModule
            [_modules setObject:module forKey:clz];
        }
    }
}

-(id)getModule:(Class)clz{
    return [_modules objectForKey:clz];
}

-(void)reg:(NSObject*) obj expr:(NSString*)expr handler:(XHandler)handler{
    [_router add:obj expr:expr target:handler];
}

-(void)unreg:(NSObject*) obj expr:(NSString*)expr{
    [_router remove:obj expr:expr];
}

-(BOOL)execute:(XContext *)context isMultiple:(BOOL)isMultiple{
    NSString* fullpath = context.fullpath;
    BOOL is_matched = FALSE;
    
    if(isMultiple){
        for(XHandler handler in [_router matches:fullpath]){
            @try {
                [self do_execute:context handler:handler];
            } @catch (NSException *ex) {
                NSLog(@"%@", ex);
            }
            is_matched = TRUE;
        }
    }else{
        XHandler handler   = [_router match:fullpath];
        [self do_execute:context handler:handler];
        is_matched = (handler != nil);
    }
    
    return is_matched;
}

-(void)do_execute:(XContext *)context handler:(XHandler)handler{
    if (handler != nil) {
        handler(context);
        [context setHandled:true];
    }
}

@end
