//
//  SogamoSession.m
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 24/10/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#define SESSION_ID_KEY @"sessionId"
#define PLAYER_ID_KEY @"playerId"
#define LOG_COLLECTOR_URL_KEY @"logCollectorURL"
#define SUGGESTION_SERVER_URL_KEY @"suggestionServerURL"
#define GAME_ID_KEY @"gameId"
#define START_DATE_KEY @"startDate"
#define IS_OFFLINE_SESSION_KEY @"isOfflineSession"
#define EVENTS_KEY @"events"

#define JSON_ACTION_KEY @"action"

#import "SogamoSession.h"

#import "SogamoJSONUtilities.h"
#import "SogamoEvent.h"
#import "ARCMacros.h"

@implementation SogamoSession

#pragma mark - Constructor

- (id)initWithSessionId:(NSString *)aSessionId
               playerId:(NSString *)aPlayerId
                 gameId:(NSInteger)aGameId
        logCollectorURL:(NSURL *)logCollectorURL
    suggestionServerURL:(NSURL *)suggestionServerURL
       isOfflineSession:(BOOL)isOffline
{
    self = [super init];
    if (self) {
        _sessionId = SAFE_ARC_RETAIN(aSessionId);
        _playerId = SAFE_ARC_RETAIN(aPlayerId);
        _gameId = aGameId;
        _logCollectorURL = SAFE_ARC_RETAIN(logCollectorURL);
        _suggestionServerURL = SAFE_ARC_RETAIN(suggestionServerURL);
        _startDate = [[NSDate alloc] init];
        _isOfflineSession = isOffline;
        _events = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - NSCoding Protocol

- (id) initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _sessionId = SAFE_ARC_RETAIN([coder decodeObjectForKey:SESSION_ID_KEY]);
        _playerId = SAFE_ARC_RETAIN([coder decodeObjectForKey:PLAYER_ID_KEY]);
        _logCollectorURL = SAFE_ARC_RETAIN([coder decodeObjectForKey:LOG_COLLECTOR_URL_KEY]);
        _suggestionServerURL = SAFE_ARC_RETAIN([coder decodeObjectForKey:SUGGESTION_SERVER_URL_KEY]);
        _startDate = SAFE_ARC_RETAIN([coder decodeObjectForKey:START_DATE_KEY]);
        _isOfflineSession = [coder decodeBoolForKey:IS_OFFLINE_SESSION_KEY];
        _gameId = [coder decodeIntegerForKey:GAME_ID_KEY];
        _events = SAFE_ARC_RETAIN([coder decodeObjectForKey:EVENTS_KEY]);
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.sessionId forKey:SESSION_ID_KEY];
    [coder encodeObject:self.playerId forKey:PLAYER_ID_KEY];
    [coder encodeObject:self.logCollectorURL forKey:LOG_COLLECTOR_URL_KEY];
    [coder encodeObject:self.suggestionServerURL forKey:SUGGESTION_SERVER_URL_KEY];
    [coder encodeObject:self.startDate forKey:START_DATE_KEY];
    [coder encodeBool:self.isOfflineSession forKey:IS_OFFLINE_SESSION_KEY];
    [coder encodeInteger:self.gameId forKey:GAME_ID_KEY];
    [coder encodeObject:self.events forKey:EVENTS_KEY];
}

#pragma mark - Convert to JSON

- (NSArray *) convertEventsToJSON
{
    NSMutableArray *outputArray = [NSMutableArray array];
    
    for (SogamoEvent *event in self.events) {
        NSString *eventJSONString = [self convertEventToJSONString:event];
        [outputArray addObject:eventJSONString];
    }
    
    return outputArray;
}

- (NSString *) convertEventToJSONString:(SogamoEvent *)event
{
    NSMutableDictionary *JSONDict = [NSMutableDictionary dictionary];
    NSString *actionValue = [NSString stringWithFormat:@"%i.%@.%@", self.gameId, event.eventName, event.eventIndex];
    [JSONDict setObject:actionValue forKey:JSON_ACTION_KEY];
    for (NSString *paramKey in [event.eventParams allKeys]) {
        id paramObject = [event.eventParams objectForKey:paramKey];
        [JSONDict setObject:[self convertParamToString:paramObject] forKey:paramKey];
    }
    
    NSString *JSONString = nil;
    NSError *error = nil;
    NSData *JSONData = SogamoJSONEncode(JSONDict, &error);
    if (error) {
        NSLog(@"JSON Encode error: %@", [error description]);
    } else {
        JSONString = SAFE_ARC_AUTORELEASE([[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding]);
    }
    
    return JSONString;
}

#pragma mark - Convenience methods

- (NSString *) convertParamToString:(id)paramObject
{
    NSString *paramString = nil;
    
    if ([paramObject isKindOfClass:[NSString class]]) {
        paramString = (NSString *)paramObject;
    } else if ([paramObject isKindOfClass:[NSDate class]]) {
        long unixTimestamp = [(NSDate *)paramObject timeIntervalSince1970];
        paramString = [NSString stringWithFormat:@"%ld", unixTimestamp];
    } else if ([paramObject isKindOfClass:[NSNumber class]]) {
        paramString = [(NSNumber *)paramObject stringValue];
    }    
    
    return paramString;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Session ID: %@, Events Count: %i, Is Offline: %i Start Date: %@", self.sessionId, [self.events count], self.isOfflineSession, [self.startDate description]];
}


- (void)dealloc
{
    SAFE_ARC_RELEASE(_sessionId);
    SAFE_ARC_RELEASE(_playerId);
    SAFE_ARC_RELEASE(_logCollectorURL);
    SAFE_ARC_RELEASE(_suggestionServerURL);
    SAFE_ARC_RELEASE(_startDate);
    SAFE_ARC_RELEASE(_events);
    SAFE_ARC_SUPER_DEALLOC();
}

@end
