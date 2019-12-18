//
//  XClient.h
//  perona
//
//  Created by noear on 2018/10/8.
//  Copyright © 2018 noear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCallback.h"

NS_ASSUME_NONNULL_BEGIN

/** 通用客户端 */
@interface XClient : NSObject
/** 调用（用于功能调用）*/
+(BOOL)call:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params;
+(BOOL)call:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params callback:(nullable XCallback)callback;
/** 发送（用于消息广播）*/
+(BOOL)send:(id)requester url:(NSString*)url params:(nullable NSDictionary*)params;

@end

NS_ASSUME_NONNULL_END
