# Sogamo Analytics API on iOS #
If you want to integrate the Sogamo Analytics API with your iPhone / iPad application, first download the latest [zip archive](http://sogamo.com/) and extract the files. 

The repository contains two folders:

1. SogamoAPI.framework - The Sogamo iOS Framework
2. HelloSogamo - A sample application that demonstrates how to use the SogamoAPI.
3. Docs

# Requirements #

1. Xcode 4.3.3 or later
2. iOS 5.0 or later

# Setup #
Adding the SogamoAPI to your Xcode project is just a few easy steps:

1. Add the SogamoAPI Framework
	a. Drag and drop the **SogamoAPI.embeddedframework** folder into your project. 
	b. Check the "Copy items into destination's group's folder" and select 'Create groups for any added folders'
![Copy][Copy into Xcode]

2. Add the SystemConfiguration Framework.
	a. In the Project navigator, select your project
	b. Select your target
	c. Select the 'Build Phases' tab
	d. Open 'Link Binaries with Libraries' expander
	e. Click the '+' button
	f. Select the **SystemConfiguration.framework** from the list (Or use the search field)
	g. (optional) Drag and drop the added framework to the 'Frameworks' group
![Add SystemConfiguration Framework][Add SystemConfiguration]

3. Add `#import <SogamoAPI/SogamoAPI.h>` to all classes that call SogamoAPI functions
		
And that's it. 

# Usage #
## Initialization ##
The first thing you need to do is to initialize a SogamoAPI session with your project API key. We recommend doing this in `applicationDidFinishLaunching:` or
`application:didFinishLaunchingWithOptions` in your Application delegate, with the following method:

	[[SogamoAPI sharedAPI] startSessionWithAPIKey:YOUR_PROJECT_KEY facebookId:USERS_FACEBOOK_ID_OR_NIL];

You can set the facebookId: parameter  to nil if that information is unavailable. We however strongly recommend that you include the Facebook ID of the user when starting the session. This will allow you to gain insight into how your users behave across all other Sogamo-linked applications that they use. Obtaining the user's Facebook ID is easy with the [Facebook SDK](https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/3.1/).

## Tracking Events ##
After initializing the SogamoAPI singleton object, you are ready to track events. This can be done with the following method:

	SogamoAPI *sogamoAPI = [SogamoAPI sharedAPI];
    [sogamoAPI trackEventWithName:@"playerTopUp" 
                           params:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"First top up", @"remarks",
                                   [NSNumber numberWithInteger:100], @"currencyEarned",
                                   [NSNumber numberWithInteger:200], @"currencyBalance",
                                   [NSDate date], @"logDatetime", nil]];

Note: Event params are to be stored in a NSDictionary object. Numeric parameters must be wrapped inside a NSNumber object, and similarly, datetime parameters are to be represented as NSDate objects.

For a full list of the events that can be tracked, visit the [Sogamo website](http://www.sogamo.com)

[Copy into Xcode]: https://github.com/zelrealm/Sogamo-iOS-library/raw/master/Docs/Images/Copy%20into%20Xcode.png "Copy into Xcode"
[Add SystemConfiguration]: https://github.com/zelrealm/Sogamo-iOS-library/raw/master/Docs/Images/Added%20SystemConfiguration%20framework.png "Add System Configuration"