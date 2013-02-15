//
//  SogamoAPI.h
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 11/9/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//
// This library lets you use Sogamo analytics in iOS applications

// Sogamo API Notification Names
#define SogamoAPIDidSuccessfullyAuthenticateNotification @"SogamoAPIDidSuccessfullyAuthenticateNotification"
#define SogamoAPIDidFailToAuthenticateNotification @"SogamoAPIDidFailToAuthenticateNotification"

#import <UIKit/UIKit.h>

@interface SogamoAPI : NSObject

/*! 
 @property   playerId
 @abstract   The identifier for the player
 @discussion If this property is left blank, an GUID is generated as a default value             
*/
@property (nonatomic, strong) NSString *playerId;

/*!
 @property   flushInterval
 @abstract   The interval (in seconds) between flush attempts (i.e sending session data to Sogamo servers)
 @discussion The default value is 0 (which means it never attempts to flush periodically). If a non-zero
             value is specified, then it begins attempts flushes at the specified intervals.
 */
@property (nonatomic) NSInteger flushInterval;

#pragma mark Singleton Methods

/*! 
 @method     sharedAPI
 @abstract   Returns the shared API object.
 @discussion Returns the Singleton instance of the SogamoAPI class. 
*/
+ (id) sharedAPI;

#pragma mark Startup

/*!
 @method     startSessionWithAPIKey:
 @abstract   Creates a session with your API Token.
 @discussion Creates a session with your authentication token. However, if the last session has not expired, 
             then it will be re-used.
             This must be the first message sent before logging any events since it performs important
             initializations to the API.
 @param      apiToken Your Sogamo API token.
*/
- (void) startSessionWithAPIKey:(NSString *)anAPIKey;

/*!
 @method     startSessionWithAPIKey:facebookId:
 @abstract   Creates a session with your API Token and the player's Facebook Id
 @discussion Creates a session with your authentication token. However, if the last session has not expired, 
 then it will be re-used.
 This must be the first message sent before logging any events since it performs important
 initializations to the API.
 @param      apiToken Your Sogamo API token.
 @param      aPlayerId The player identifier (optimally this should be their Facebook ID)
 @param      playerDetails Details about the player (i.e firstname, lastname, dob, email, gender etc.) 
             Refer to the 'session' event for full set of player details that is accepted
 */
- (void) startSessionWithAPIKey:(NSString *)anAPIKey playerId:(NSString *)aPlayerId playerDetails:(NSDictionary *)playerDetails;

#pragma mark Event Tracking

/*!
 @method     trackEventWithName:data:
 @abstract   Tracks an event identified by its name
 @discussion Tracks an event identifier by its name. All parameters for the event must be 
             packaged in a NSDictionary, with the keys being the the parameter names.
             E.g [NSDictionary dictionaryWithObjectsAndKeys:@"JohnDoe", @"username",
                                                            @"John", @"firstname",
                                                            @"Doe", @"lastname", nil];
 
             Numeric parameter values should be wrapped in NSNumber objects.
             Datetime parameter values should be given as NSDate objects.
 
             Note: The following parameters need not be included as they will be populated automatically:
             - sessionId / session_id
             - gameId / game_id
             - playerId / player_id
             - login_datetime

 @param      eventName Name of the event to be tracked
 @param      params      A NSDictionary of the all the parameters for the event
 */
- (void) trackEventWithName:(NSString *)eventName params:(NSDictionary *)paramsDict;

@end
