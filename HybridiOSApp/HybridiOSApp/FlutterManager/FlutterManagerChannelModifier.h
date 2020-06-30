//
//  FlutterManagerChannelModifier.h
//  HybridiOSApp
//
//  Created by neotv on 2020/6/30.
//  Copyright © 2020 neotv. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSArray * _Nullable (^FlutterManagerChannelModifierBlock)(NSArray * _Nonnull channels);

NS_ASSUME_NONNULL_BEGIN

@protocol FlutterManagerChannelModifier <NSObject>

- (nullable NSArray *)modifiedChannelsWithChannels:(nonnull NSArray *)channels;

@end

@interface FlutterManagerChannelModifier : NSObject<FlutterManagerChannelModifier>

/// Create the channel modifier with block
/// @param block A block to control modifier logic
- (nonnull instancetype)initWithBlock:(nonnull FlutterManagerChannelModifierBlock)block;

/// Create the channel modifier with block
/// @param block A block to control modifier logic
+ (nonnull instancetype)channelsModifierWithBlock:(nonnull FlutterManagerChannelModifierBlock)block;
@end

NS_ASSUME_NONNULL_END
