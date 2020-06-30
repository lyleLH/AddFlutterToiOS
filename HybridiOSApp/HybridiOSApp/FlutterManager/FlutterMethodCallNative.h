//
//  FlutterMethodCallNative.h
//  HybridiOSApp
//
//  Created by neotv on 2020/6/30.
//  Copyright © 2020 neotv. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FlutterMethodCallNativeBlock)(id _Nonnull arguments);

NS_ASSUME_NONNULL_BEGIN

@interface FlutterMethodCallNative : NSObject

///< Flutter 调用原生的 方法名
@property (nonatomic, strong) NSString *methodName;

///< 调用方法
@property (nonatomic, copy) FlutterMethodCallNativeBlock hander;

- (instancetype)initWithMethodName:(NSString *)methodName hander:(FlutterMethodCallNativeBlock)hander;

+ (instancetype)callWithMethodName:(NSString *)methodName  hander:(FlutterMethodCallNativeBlock)hander;

@end

NS_ASSUME_NONNULL_END
