//
//  SogamoEvent.h
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 24/10/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SogamoEvent : NSObject<NSCoding>

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventIndex;
@property (nonatomic, retain) NSMutableDictionary *eventParams;

#pragma mark - Constructor

- (id)initWithName:(NSString *)name index:(NSString *)index params:(NSDictionary *)params;

@end
