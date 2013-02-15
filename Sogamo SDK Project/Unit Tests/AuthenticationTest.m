//
//  AuthenticationTest.m
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 12/9/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import "AuthenticationTest.h"

#import "SogamoAPI.h"

@implementation AuthenticationTest

@synthesize done;

#pragma mark Setup and Teardown

- (void)setUp 
{
    sogamoAPI = [[SogamoAPI sharedAPI] retain];
    self.done = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSogamoAPIDidSuccessfullyAuthenticateNotification:) 
                                                 name:SogamoAPIDidSuccessfullyAuthenticateNotification 
                                               object:nil];
    
    STAssertNotNil(sogamoAPI, @"Could not create test subject.");
}

- (void)tearDown 
{
    [sogamoAPI release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Tests

- (void) testAuthentication
{
    [sogamoAPI startSessionWithAPIKey:@"e13e6a3595aa4287a6a14a3d0ee7df30"];
    STAssertTrue([self waitForCompletion:20.0], @"Failed to get any results in time");    
    STAssertTrue([sogamoAPI validateSession], @"Session Key is nil after authentication");
}

#pragma mark Convenience Methods

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs 
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!self.done);

    return self.done;
}

#pragma mark Notification Handling

- (void) handleSogamoAPIDidSuccessfullyAuthenticateNotification:(NSNotification *)notification
{
//    NSLog(@"handleSogamoAPIDidSuccessfullyAuthenticateNotification");
    self.done = YES;
}

@end
