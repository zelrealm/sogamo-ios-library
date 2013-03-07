//
//  SogamoAuthenticationResponse.h
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 7/3/13.
//  Copyright (c) 2013 White Dwarf Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SogamoAuthenticationResponse : NSObject

@property (nonatomic) NSInteger gameId;
@property (nonatomic, strong) NSString* sessionId;
@property (nonatomic, strong) NSString* playerId;
@property (nonatomic, strong) NSURL* logCollectorURL;
@property (nonatomic, strong) NSURL* suggestionServerURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
