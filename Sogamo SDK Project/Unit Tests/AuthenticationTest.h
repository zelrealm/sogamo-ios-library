//
//  AuthenticationTest.h
//  Sogamo SDK
//
//  Created by Muhammad Mohsin on 12/9/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class SogamoAPI;

@interface AuthenticationTest : SenTestCase {
    SogamoAPI *sogamoAPI;
}

@property BOOL done;

@end
