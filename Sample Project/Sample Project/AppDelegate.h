//
//  AppDelegate.h
//  Sample Project
//
//  Created by Muhammad Mohsin on 8/10/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
