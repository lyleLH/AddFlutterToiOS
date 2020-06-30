//
//  FlutterManagerChannelModifier.m
//  HybridiOSApp
//
//  Created by neotv on 2020/6/30.
//  Copyright © 2020 neotv. All rights reserved.
//

#import "FlutterManagerChannelModifier.h"

@interface FlutterManagerChannelModifier ()

@property (nonatomic, copy, nonnull) FlutterManagerChannelModifierBlock block;

@end

@implementation FlutterManagerChannelModifier

- (instancetype)initWithBlock:(FlutterManagerChannelModifierBlock)block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

+ (instancetype)channelsModifierWithBlock:(FlutterManagerChannelModifierBlock)block {
    FlutterManagerChannelModifier * channelModifier = [[FlutterManagerChannelModifier alloc] initWithBlock:block];
    return channelModifier;
}

- (NSArray *)modifiedChannelsWithChannels:(NSArray *)channels {
    if (!self.block) {
        return nil;
    }
    return self.block(channels);
}

@end
