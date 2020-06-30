//
//  FlutterMethodCallNative.m
//  HybridiOSApp
//
//  Created by neotv on 2020/6/30.
//  Copyright © 2020 neotv. All rights reserved.
//

#import "FlutterMethodCallNative.h"

@implementation FlutterMethodCallNative

- (instancetype)initWithMethodName:(NSString *)methodName  hander:(FlutterMethodCallNativeBlock)hander {
    if (self = [super init]) {
        self.methodName = methodName;
        self.hander = hander;
    }
    return self;
}


+ (instancetype)callWithMethodName:(NSString *)methodName  hander:(FlutterMethodCallNativeBlock)hander {
    return [[FlutterMethodCallNative alloc] initWithMethodName:methodName hander:hander];
}

@end
