//
//  ViewController.m
//  Sample Project
//
//  Created by Muhammad Mohsin on 8/10/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import "ViewController.h"

#import "SampleCallsTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <SogamoAPI/SogamoAPI.h>
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize startSessionWithFacebookButton;
@synthesize startSessionButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Sogamo Sample App";
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSogamoAPIDidSuccessfullyAuthenticateNotification:) 
                                                 name:SogamoAPIDidSuccessfullyAuthenticateNotification 
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSogamoAPIDidFailToAuthenticateNotification:) 
                                                 name:SogamoAPIDidFailToAuthenticateNotification 
                                               object:nil];
}

- (void)viewDidUnload
{
    [self setStartSessionWithFacebookButton:nil];
    [self setStartSessionButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - IBActions


- (IBAction) startSessionWithFacebookButtonTapped:(id)sender 
{
    [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects:nil]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                      [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                                          NSString *facebookId = user.id;
                                          NSDictionary *playerDetails = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                         user.username, @"username",
                                                                         user.first_name, @"firstname",
                                                                         user.last_name, @"lastname",
                                                                         nil];
                                          [[SogamoAPI sharedAPI] startSessionWithAPIKey:@"e13e6a3595aa4287a6a14a3d0ee7df30" playerId:facebookId
                                                                          playerDetails:playerDetails];
                                      }];      
                                      
                                  }];
}

- (IBAction) startSessionButtonTapped:(id)sender 
{
    // Start the Sogamo session
    [[SogamoAPI sharedAPI] startSessionWithAPIKey:@"e13e6a3595aa4287a6a14a3d0ee7df30"];
}

#pragma mark - Push To Sample Calls Table View

- (void) pushToSampleCallsTableView
{
    SampleCallsTableViewController *sampleCallsController = [[SampleCallsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:sampleCallsController animated:YES];
    [sampleCallsController release];
}

#pragma mark - Handle Notifications

- (void) handleSogamoAPIDidSuccessfullyAuthenticateNotification:(NSNotification *)notification
{
    SogamoAPI *sogamoAPI = [SogamoAPI sharedAPI];
    if (FBSession.activeSession.isOpen) {
        // Successfully started session with Facebook ID
        NSLog(@"Successfully started session with Facebook ID: %@", sogamoAPI.playerId);
    } else {
        // Successfully started session without Facebook ID
        NSLog(@"Successfully started session without Facebook ID");
    }
 
    [self performSelectorOnMainThread:@selector(pushToSampleCallsTableView) withObject:nil waitUntilDone:YES];
}

- (void) handleSogamoAPIDidFailToAuthenticateNotification:(NSNotification *)notification
{
    // Failed to start session
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [startSessionWithFacebookButton release];
    [startSessionButton release];
    [super dealloc];
}
@end
