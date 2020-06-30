//
//  FlutterManager.h
//  HybridiOSApp
//
//  Created by neotv on 2020/6/30.
//  Copyright © 2020 neotv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import "FlutterManagerChannelModifier.h"
#import "FlutterMethodCallNative.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlutterManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) UIViewController *controller;

@property (nonatomic, strong, readonly) FlutterMethodChannel *methodChannel;

@property (nonatomic, strong, nullable) id<FlutterManagerChannelModifier> channelsModifier;

// 注入通信
- (void)syncChannels;

@end

NS_ASSUME_NONNULL_END
