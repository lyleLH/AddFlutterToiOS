//
//  YKFlutterBridge.h
//  HybridiOSApp
//
//  Created by Tom.Liu on 2021/7/9.
//  Copyright © 2021 neotv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "YKFlutterBridgeInterface.h"
NS_ASSUME_NONNULL_BEGIN


@interface YKFlutterBridge : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong, readonly) UIViewController *controller;
@property (nonatomic, strong, readonly) FlutterBasicMessageChannel *messageChannel;
@property (nonatomic, weak) id  <YKFlutterBridgeInterface> delegate;
- (void)callFlutter:(id)call  reply:(FlutterReply _Nullable)callback ;
@end

NS_ASSUME_NONNULL_END
