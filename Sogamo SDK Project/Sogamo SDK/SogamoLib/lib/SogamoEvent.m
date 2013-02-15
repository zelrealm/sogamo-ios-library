//
//  SogamoEvent.m
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 24/10/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#define EVENT_NAME_KEY @"eventName"
#define EVENT_INDEX_KEY @"eventIndex"
#define EVENT_PARAMS_KEY @"eventParams"

#import "SogamoEvent.h"
#import "ARCMacros.h"

@implementation SogamoEvent

#pragma mark - Constructor

- (id)initWithName:(NSString *)name index:(NSString *)index params:(NSDictionary *)params;
{
    self = [super init];
    if (self) {
        _eventName = [[NSString alloc] initWithString:name];
        _eventIndex = [[NSString alloc] initWithString:index];
        _eventParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    }
    return self;
}

#pragma mark - NSCoding Protocol

- (id) initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _eventName = SAFE_ARC_RETAIN([coder decodeObjectForKey:EVENT_NAME_KEY]);
        _eventIndex = SAFE_ARC_RETAIN([coder decodeObjectForKey:EVENT_INDEX_KEY]);
        _eventParams = SAFE_ARC_RETAIN([coder decodeObjectForKey:EVENT_PARAMS_KEY]);
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.eventName forKey:EVENT_NAME_KEY];
    [coder encodeObject:self.eventIndex forKey:EVENT_INDEX_KEY];
    [coder encodeObject:self.eventParams forKey:EVENT_PARAMS_KEY];
}

#pragma mark - Dealloc

- (void)dealloc
{
    SAFE_ARC_RELEASE(_eventName);
    SAFE_ARC_RELEASE(_eventIndex);
    SAFE_ARC_RELEASE(_eventParams);
    SAFE_ARC_SUPER_DEALLOC();
}

@end
