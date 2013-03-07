//
//  SogamoSession.h
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 24/10/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SogamoEvent;

@interface SogamoSession : NSObject<NSCoding>

@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *playerId;
@property (nonatomic, strong) NSURL *logCollectorURL;
@property (nonatomic, strong) NSURL *suggestionServerURL;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic) BOOL isOfflineSession;
@property (nonatomic) NSInteger gameId;
@property (nonatomic, strong) NSMutableArray *events;

#pragma mark - Constructor

- (id)initWithSessionId:(NSString *)aSessionId 
               playerId:(NSString *)aPlayerId 
                 gameId:(NSInteger)aGameId
        logCollectorURL:(NSURL *)logCollectorURL
    suggestionServerURL:(NSURL *)suggestionServerURL
       isOfflineSession:(BOOL)isOffline;

#pragma mark - Convert to JSON

- (NSArray *) convertEventsToJSON;
- (NSString *) convertEventToJSONString:(SogamoEvent *)event;

#pragma mark - Convenience methods

- (NSString *) convertParamToString:(id)paramObject;

@end
