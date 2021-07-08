//
//  FlutterManager.m
//  HybridiOSApp
//
//  Created by neotv on 2020/6/30.
//  Copyright © 2020 neotv. All rights reserved.
//

#import "FlutterManager.h"

@interface FlutterManager ()

@property (nonatomic, strong) FlutterEngine *engine;

@property (nonatomic, strong) FlutterViewController *controller;

@property (nonatomic, strong) FlutterMethodChannel *methodChannel;
@property (nonatomic, strong) FlutterBasicMessageChannel *messageChannel;
///< 记录通信方法
@property (nonatomic, strong) NSMutableArray *recordMethods;

@end

@implementation FlutterManager

+ (instancetype)sharedInstance
{
    static FlutterManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FlutterManager alloc] init];
    });
    return _sharedClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化 controller
        self.controller = [[FlutterViewController alloc] initWithEngine:self.engine nibName:nil bundle:nil];
        
 
        self.recordMethods = @[].mutableCopy;
        
 
        self.methodChannel = [FlutterMethodChannel methodChannelWithName:@"com.zsy/hybrid" binaryMessenger:self.controller]
        ;
        self.messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"com.zsy/hybrid.messagechannelname" binaryMessenger:self.controller codec:[FlutterJSONMessageCodec new]];
    }
    return self;
}

- (void)syncChannels {
    id<FlutterManagerChannelModifier> channelModifier;
    if (self.channelsModifier) {
        channelModifier = self.channelsModifier;
    }
    
    NSArray *channels = [channelModifier modifiedChannelsWithChannels:@[]];
    
    // flutter 调用原生方法
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        [channels enumerateObjectsUsingBlock:^(FlutterMethodCallNative * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if ([call.method isEqualToString:obj.methodName]) {
                
                if (obj.hander) {
                    obj.hander(call.arguments);
                }
            }
        }];
    }];
    
    [self.messageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        NSLog(@"native side recieved :\n%@",message);
        callback(@{@"code":@"0",
                   @"msg":@"success",
                   @"data" : @{}
                 });
    }];
}

/**
 * 懒加载
 */
- (FlutterEngine *)engine {
    if (_engine == nil) {
        FlutterEngine * engine = [[FlutterEngine alloc] initWithName:@"custom_engine"];
        if (engine.run) {
            _engine = engine;
        }
    }
    return _engine;
}
@end
