//
//  SampleCallsTableViewController.m
//  Sample Project
//
//  Created by Muhammad Mohsin on 11/11/12.
//  Copyright (c) 2012 White Dwarf Labs. All rights reserved.
//

#import "SampleCallsTableViewController.h"

#import <SogamoAPI/SogamoAPI.h>

@interface SampleCallsTableViewController ()

@end

@implementation SampleCallsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Sample API Calls";
    self.navigationItem.hidesBackButton = YES;
 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"session (new)";
            break;
        case 1:
            cell.textLabel.text = @"session (update)";
            break;
        case 2:
            cell.textLabel.text = @"inviteSent";
            break;
        case 3:
            cell.textLabel.text = @"inviteResponse";
            break;
        case 4:
            cell.textLabel.text = @"levelUp";
            break;
        case 5:
            cell.textLabel.text = @"itemChange";
            break;
        case 6:
            cell.textLabel.text = @"miscExpenditures";
            break;
        case 7:
            cell.textLabel.text = @"playerTopUp";
            break;
        case 8:
            cell.textLabel.text = @"payment";
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *eventName = nil;
    NSDictionary *eventParams = nil;
    
    switch (indexPath.row) {
        case 0:
            eventName = @"session";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1001", @"gameId",
                           @"5001", @"player_id",
                           @"alex", @"username",
                           @"Alex", @"firstname",
                           @"Titlyanov", @"lastname",
                           @"1-1-1980", @"dob",
                           @"5001@gmail.com", @"email",
                           @"male", @"gender",
                           @"", @"relationship_status",
                           [NSNumber numberWithInteger:2], @"number_of_friends",
                           @"New", @"status",
                           @"0", @"credit",
                           @"", @"currency",
                           nil];
            break;
        case 1:
            eventName = @"session";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1001", @"gameId",
                           @"5001", @"player_id",                           
                           nil];
            break;
        case 2:
            eventName = @"inviteSent";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"738867", @"inviteId",
                           @"JOIN_GAME", @"inviteType",
                           @"205,206,207", @"recipientIds",
                           @"alex", @"screenName",
                           @"5001", @"playerId",
                           @"", @"attributes",
                           @"0", @"credit",
                           @"1", @"level",
                           @"0", @"experience",
                           @"G=1", @"virtualCurrency",
                           nil];
            break;
        case 3:
            eventName = @"inviteResponse";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"738867", @"inviteId",
                           @"205", @"respondedPlayerId",
                           [NSDate date], @"responseDatetime",
                           @"1", @"respondedPlayerStatus",
                           nil];
            break;
        case 4:
            eventName = @"levelUp";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"100", @"playerId",
                           @"", @"attributes",
                           @"0", @"credit",
                           @"2", @"level",
                           @"0", @"experience",
                           @"G=1", @"virtualCurrency",
                           @"2", @"presentLevel",
                           [NSDate date], @"levelupDatetime",
                           @"AEK971,C4_EXPLOSIVES", @"itemsUnlocked",
                           nil];
            break;
        case 5:
            eventName = @"itemChange";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"5001", @"playerId",
                           @"", @"attributes",
                           @"", @"itemsInUse",
                           @"DORY,CHICKEN_CUTLET,CHICKEN_CUTLET", @"itemsInInventory",
                           @"0", @"credit",
                           @"1", @"level",
                           @"0", @"experience",
                           @"G=1", @"virtualCurrency",
                           @"1", @"logAction",
                           @"", @"itemsRemaining",
                           @"", @"itemsRemainingQuantity",
                           @"CHICKEN_CUTLET", @"itemsBought",
                           @"1", @"itemsBoughtQuantity",
                           @"Credit=3", @"itemsBoughtPrice",
                           nil];
            break;
        case 6:
            eventName = @"miscExpenditures";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"", @"attributes",
                           @"0", @"credit",
                           @"1", @"level",
                           @"", @"experience",
                           @"Credit=100,Coins=200", @"currencySpent",
                           @"1", @"logAction",
                           nil];
            break;
        case 7:
            eventName = @"playerTopUp";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1001", @"gameId",
                           @"5001", @"playerId",
                           @"300", @"currencyEarned",
                           @"500", @"currencyBalance",
                           @"", @"remarks",
                           nil];
            break;
        case 8:
            eventName = @"payment";
            eventParams = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1001", @"gameId",
                           @"5001", @"playerId",
                           @"2", @"level",
                           @"10", @"creditSpent",
                           @"G=1000", @"resourceBought",
                           [NSNumber numberWithFloat:0.124], @"exchangeRate",
                           @"SGD", @"realCurrency",
                           nil];
            break;
    }
    
    if (eventName && eventParams)
        [[SogamoAPI sharedAPI] trackEventWithName:eventName params:eventParams];
}

@end
