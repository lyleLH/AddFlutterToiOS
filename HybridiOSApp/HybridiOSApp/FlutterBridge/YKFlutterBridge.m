//
//  YKFlutterBridge.m
//  HybridiOSApp
//
//  Created by Tom.Liu on 2021/7/9.
//  Copyright © 2021 neotv. All rights reserved.
//

#import "YKFlutterBridge.h"

@interface YKFlutterBridge ()
@property (nonatomic, strong) FlutterEngine *engine;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) FlutterBasicMessageChannel *messageChannel;
@end

@implementation YKFlutterBridge

+ (instancetype)sharedInstance
{
    static YKFlutterBridge *_bridge = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _bridge = [[super allocWithZone:NULL] init] ;
    });
    return _bridge;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.controller = [[FlutterViewController alloc] initWithEngine:self.engine nibName:nil bundle:nil];
        self.messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"com.zsy/hybrid.messagechannelname" binaryMessenger:self.controller codec:[FlutterJSONMessageCodec new]];
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.messageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
    //            NSLog(@"native side recieved :\n%@",message);
                if(weakSelf.delegate){
                    if([weakSelf.delegate respondsToSelector:@selector(handlerMessageFromFlutter:thenCallBackToFlutter:)]){
                        [weakSelf.delegate handlerMessageFromFlutter:message thenCallBackToFlutter:callback];
                    }else{
                        
                    }
                }else{
                    NSLog(@"🔥🔥🔥🔥🔥🔥 \n请设置好 处理flutter调用相应的代理YKFlutterBridgeInterface\n🔥🔥🔥🔥🔥🔥 ");
                }
                
            }];
        });
    }
    return self;
}

//用alloc返回也是唯一实例
+(id) allocWithZone:(struct _NSZone *)zone {
   return [YKFlutterBridge sharedInstance] ;
}
//对对象使用copy也是返回唯一实例
-(id)copyWithZone:(NSZone *)zone {
   return [YKFlutterBridge sharedInstance] ;
}
//对对象使用mutablecopy也是返回唯一实例
-(id)mutableCopyWithZone:(NSZone *)zone {
   return [YKFlutterBridge sharedInstance] ;
}


 
- (void)callFlutter:(id)call  reply:(FlutterReply _Nullable)callback {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageChannel sendMessage:@{@"key1":@"1",@"key2":@"2",@"key3":@"3"} reply:^(id  _Nullable reply) {
            NSLog(@"native call flutter callbacked :\n %@",reply);
        }];
    });

}






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
