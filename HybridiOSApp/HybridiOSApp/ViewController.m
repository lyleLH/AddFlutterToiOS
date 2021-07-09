//
//  ViewController.m
//  HybridiOSApp
//
//  Created by neotv on 2020/6/28.
//  Copyright © 2020 neotv. All rights reserved.
//

#import "ViewController.h"
#import "FlutterManager.h"

#import "YKFlutterBridge.h"
@interface ViewController () <YKFlutterBridgeInterface>

@end

@implementation ViewController

 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
//    FlutterManagerChannelModifier * channels = [FlutterManagerChannelModifier channelsModifierWithBlock:^NSArray * _Nullable(NSArray * _Nonnull channels) {
//        return @[
//            [FlutterMethodCallNative callWithMethodName:@"sayHi" hander:^(id  _Nonnull arguments) {
//                NSLog(@"Hi: %@", arguments);
//            }],
//            [FlutterMethodCallNative callWithMethodName:@"sayError" hander:^(id  _Nonnull arguments) {
//                NSLog(@"Error: %@", arguments);
//            }],
//            [FlutterMethodCallNative callWithMethodName:@"sayOK" hander:^(id  _Nonnull arguments) {
//                NSLog(@"Hi: %@", arguments);
//            }],
//        ];
//    }];
//
//    [FlutterManager sharedInstance].channelsModifier = channels;
//    [[FlutterManager sharedInstance] syncChannels];

    YKFlutterBridge * bridge = [[YKFlutterBridge alloc] init];
    bridge.delegate = self;

}

 
- (void)handlerMessageFromFlutter:(NSDictionary *)message thenCallBackToFlutter:(FlutterReply)callback {
    NSLog(@"%@",message);
    callback(@{@"hello":@"world"});
}


- (IBAction)showFlutterPage:(id)sender {
    
//    [self showDetailViewController:[FlutterManager sharedInstance].controller sender:nil];
        [self showDetailViewController:[YKFlutterBridge sharedInstance].controller sender:nil];
}


- (IBAction)callflutter:(id)sender {
   
}



- (IBAction)msgCallFlutter:(id)sender {
//    [[FlutterManager sharedInstance].messageChannel sendMessage:@{@"key1":@"1",@"key2":@"2",@"key3":@"3"} reply:^(id  _Nullable reply) {
//
//        NSLog(@"native call flutter callbacked :\n %@",reply);
//
//    }];
    
    [[YKFlutterBridge sharedInstance] callFlutter:@{@"key1":@"1",@"key2":@"2",@"key3":@"3"} reply:^(id  _Nullable reply) {
        NSLog(@"native call flutter callbacked :\n %@",reply);
    }];
    
}

@end
