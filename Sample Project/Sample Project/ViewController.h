//
//  ViewController.h
//  Sample Project
//
//  Created by Muhammad Mohsin on 8/10/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

#pragma mark - Interface Builder Outlets
@property (retain, nonatomic) IBOutlet UIButton *startSessionWithFacebookButton;
@property (retain, nonatomic) IBOutlet UIButton *startSessionButton;

#pragma mark - Interface Builder Actions
- (IBAction)startSessionWithFacebookButtonTapped:(id)sender;
- (IBAction)startSessionButtonTapped:(id)sender;

@end
