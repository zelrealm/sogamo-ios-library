//
//  SogamoAuthenticationResponse.m
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 7/3/13.
//  Copyright (c) 2013 White Dwarf Labs. All rights reserved.
//

#define AUTHENTICATION_RESPONSE_GAME_ID_KEY @"game_id"
#define AUTHENTICATION_RESPONSE_SESSION_ID_KEY @"session_id"
#define AUTHENTICATION_RESPONSE_PLAYER_ID_KEY @"player_id"
#define AUTHENTICATION_RESPONSE_LOG_COLLECTOR_URL_KEY @"lc_url"
#define AUTHENTICATION_RESPONSE_SUGGESTION_SERVER_URL_KEY @"su_url"

#import "SogamoAuthenticationResponse.h"

#import "ARCMacros.h"

@interface SogamoAuthenticationResponse()

#pragma mark - Validation

- (BOOL) validateDictionary:(NSDictionary *)dictionary;

@end

@implementation SogamoAuthenticationResponse

#pragma mark - Constructor

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if ([self validateDictionary:dictionary]) {
            _gameId = [[dictionary objectForKey:AUTHENTICATION_RESPONSE_GAME_ID_KEY] integerValue];
            _sessionId = SAFE_ARC_RETAIN([dictionary objectForKey:AUTHENTICATION_RESPONSE_SESSION_ID_KEY]);
            _playerId = SAFE_ARC_RETAIN([dictionary objectForKey:AUTHENTICATION_RESPONSE_PLAYER_ID_KEY]);

            NSString *logCollectorURLString = [dictionary objectForKey:AUTHENTICATION_RESPONSE_LOG_COLLECTOR_URL_KEY];
            NSString *suggestionServerURLString = [dictionary objectForKey:AUTHENTICATION_RESPONSE_SUGGESTION_SERVER_URL_KEY];
            // Check if the url string have the http:// prefix.
            NSString *httpScheme = @"http://";
            if ([logCollectorURLString rangeOfString:httpScheme].location == NSNotFound) {
                logCollectorURLString = [NSString stringWithFormat:@"%@%@", httpScheme, logCollectorURLString];
            }
            if ([suggestionServerURLString rangeOfString:httpScheme].location == NSNotFound) {
                suggestionServerURLString = [NSString stringWithFormat:@"%@%@", httpScheme, suggestionServerURLString];
            }
            
            _logCollectorURL = SAFE_ARC_RETAIN([NSURL URLWithString:logCollectorURLString]);
            _suggestionServerURL = SAFE_ARC_RETAIN([NSURL URLWithString:suggestionServerURLString]);
        } else {
            self = nil;
        }
    }
    return self;
}

#pragma mark - Validation

- (BOOL) validateDictionary:(NSDictionary *)dictionary
{
    BOOL isValid = YES;
    
    if (![dictionary objectForKey:AUTHENTICATION_RESPONSE_GAME_ID_KEY]) {
        isValid = NO;
        NSLog(@"Game Id Missing!");
    }
    
    if (![dictionary objectForKey:AUTHENTICATION_RESPONSE_SESSION_ID_KEY]) {
        isValid = NO;
        NSLog(@"Session Key Missing!");
    }
    
    if (![dictionary objectForKey:AUTHENTICATION_RESPONSE_PLAYER_ID_KEY]) {
        isValid = NO;
        NSLog(@"Player ID Missing!");
    }
    
    if (![dictionary objectForKey:AUTHENTICATION_RESPONSE_LOG_COLLECTOR_URL_KEY]) {
        isValid = NO;
        NSLog(@"Log Collector URL Missing!");
    }
    
    if (![dictionary objectForKey:AUTHENTICATION_RESPONSE_SUGGESTION_SERVER_URL_KEY]) {
        isValid = NO;
        NSLog(@"Suggestion Server URL Missing!");
    }
    
    return isValid;
}

- (void)dealloc
{
    SAFE_ARC_RELEASE(_sessionId);
    SAFE_ARC_RELEASE(_playerId);
    SAFE_ARC_RELEASE(_logCollectorURL);
    SAFE_ARC_RELEASE(_suggestionServerURL);
    SAFE_ARC_SUPER_DEALLOC();
}
@end
