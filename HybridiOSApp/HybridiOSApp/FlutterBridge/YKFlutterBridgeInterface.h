//
//  YKFlutterBridgeInterface.h
//  HybridiOSApp
//
//  Created by Tom.Liu on 2021/7/9.
//  Copyright © 2021 neotv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YKFlutterBridgeInterface <NSObject>
- (void)handlerMessageFromFlutter:(NSDictionary *)message thenCallBackToFlutter:(FlutterReply)callback;
@end

NS_ASSUME_NONNULL_END
