//
//  SogamoSuggestionResponse.m
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 12/3/13.
//  Copyright (c) 2013 White Dwarf Labs. All rights reserved.
//

#define SUGGESTION_RESPONSE_GAME_ID_KEY @"game_id"
#define SUGGESTION_RESPONSE_PLAYER_ID_KEY @"player_id"
#define SUGGESTION_RESPONSE_SUGGESTION_TYPE_KEY @"suggestion_type"
#define SUGGESTION_RESPONSE_SUGGESTION_KEY @"suggestion"

#import "SogamoSuggestionResponse.h"

#import "ARCMacros.h"

@interface SogamoSuggestionResponse()

#pragma mark - Validation

- (BOOL) validateDictionary:(NSDictionary *)dictionary;

@end

@implementation SogamoSuggestionResponse

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if ([self validateDictionary:dictionary]) {
            _gameId = [[dictionary objectForKey:SUGGESTION_RESPONSE_GAME_ID_KEY] integerValue];
            _playerId = SAFE_ARC_RETAIN([dictionary objectForKey:SUGGESTION_RESPONSE_PLAYER_ID_KEY]);
            _suggestionType = SAFE_ARC_RETAIN([dictionary objectForKey:SUGGESTION_RESPONSE_SUGGESTION_TYPE_KEY]);
            _suggestion = SAFE_ARC_RETAIN([dictionary objectForKey:SUGGESTION_RESPONSE_SUGGESTION_KEY]);
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
    
    if (![dictionary objectForKey:SUGGESTION_RESPONSE_GAME_ID_KEY]) {
        isValid = NO;
        NSLog(@"Game Id Missing!");
    }
    
    if (![dictionary objectForKey:SUGGESTION_RESPONSE_PLAYER_ID_KEY]) {
        isValid = NO;
        NSLog(@"Player ID Missing!");
    }
    
    if (![dictionary objectForKey:SUGGESTION_RESPONSE_SUGGESTION_TYPE_KEY]) {
        isValid = NO;
        NSLog(@"Suggestion Type Missing!");
    }
    
    if (![dictionary objectForKey:SUGGESTION_RESPONSE_SUGGESTION_KEY]) {
        isValid = NO;
        NSLog(@"Suggestion Missing!");
    }
    
    return isValid;
}

- (void)dealloc
{
    SAFE_ARC_RELEASE(_playerId);
    SAFE_ARC_RELEASE(_suggestionType);
    SAFE_ARC_RELEASE(_suggestion);
    SAFE_ARC_SUPER_DEALLOC();
}


@end
