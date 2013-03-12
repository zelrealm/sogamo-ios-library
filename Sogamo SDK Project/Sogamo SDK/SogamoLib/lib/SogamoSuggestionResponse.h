//
//  SogamoSuggestionResponse.h
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 12/3/13.
//  Copyright (c) 2013 White Dwarf Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SogamoSuggestionResponse : NSObject

@property (nonatomic) NSInteger gameId;
@property (nonatomic, strong) NSString *playerId;
@property (nonatomic, strong) NSString *suggestionType;
@property (nonatomic, strong) NSString *suggestion;

#pragma mark Constructor

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
