//
//  PickerViewAppDelegate.m
//  PickerView
//
//  Created by Bistro Studios on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PickerViewAppDelegate.h"
#import "PickerViewViewController.h"
#import "FilterView.h"
#import "DayView.h"
#import "Reachability.h"
#import "NoConnectionPage.h"
#import "Update.h"
#import "GANTracker.h"

static const NSInteger kGANDispatchPeriodSec = 10;

@implementation PickerViewAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize view2Controller;
@synthesize view3Controller;
@synthesize view4Controller;
@synthesize view5Controller;
@synthesize customDay;
@synthesize fileContents;
@synthesize lastRow;
@synthesize list;
@synthesize filterWords;
@synthesize filteredList;
@synthesize locationList;
@synthesize locationFilteredList;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	// Set the view controller as the window's root view controller and display.
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [self animateSplashScreen];
    [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-28203462-1" dispatchPeriod:kGANDispatchPeriodSec delegate:nil];
    NSError *error;    
    if (![[GANTracker sharedTracker] trackPageview:@"App Loaded"
                                         withError:&error])
    {
        // Handle error here
    }
	
    customDay = nil;
    lastRow = nil;
	customDayOn = FALSE;
    list = [[NSMutableArray alloc] init];
    filteredList = [[NSMutableArray alloc] init];
    locationList = [[NSMutableArray alloc] init];
    filterWords = [[NSMutableArray alloc] init];
    useFilter = FALSE;
    filtersOff = TRUE;
    sortAlphebetically = TRUE;

    return YES;
}

-(void)setFiltersBool:(BOOL)allFiltersOff {
    filtersOff = allFiltersOff;
}

-(void)restartPicker:(BOOL)cancel{
    [viewController.view removeFromSuperview];
    [viewController release];
	viewController = [[PickerViewViewController alloc] init];
    [viewController shouldSortByLocation:FALSE];
    [viewController setLastRowZero];
    if (!cancel) {
        [viewController applyFilter:filtersOff];
    }
    //[viewController customLoadComponents];
    self.window.rootViewController = viewController;
}

-(void)restartPickerForNewDay {
    [viewController.view removeFromSuperview];
    [viewController release];
    view2Controller = [[FilterView alloc] init];
    self.window.rootViewController = view2Controller;
    [view2Controller.view removeFromSuperview];
	viewController = [[PickerViewViewController alloc] init];
    [viewController shouldSortByLocation:FALSE];
    [viewController setLastRowZero];
    [filterWords removeAllObjects];
    self.window.rootViewController = viewController;
}

-(BOOL)shouldSortByClosest{
    return sortAlphebetically;
}

-(void)sortBarsByClosest {
    sortAlphebetically = FALSE;
    [self sortLocation];
    [viewController.view removeFromSuperview];
    [viewController release];
    view2Controller = [[FilterView alloc] init];
    self.window.rootViewController = view2Controller;
    [view2Controller.view removeFromSuperview];
    viewController = [[PickerViewViewController alloc] init];
    [viewController shouldSortByLocation:TRUE];
    [viewController setLastRowZero];
    [filterWords removeAllObjects];
    self.window.rootViewController = viewController;
}

-(void)sortBarsAlphebetically {
    sortAlphebetically = TRUE;
    [self sortAlphabetically];
    [viewController.view removeFromSuperview];
    [viewController release];
    view2Controller = [[FilterView alloc] init];
    self.window.rootViewController = view2Controller;
    [view2Controller.view removeFromSuperview];
    viewController = [[PickerViewViewController alloc] init];
    [viewController shouldSortByLocation:FALSE];
    [viewController setLastRowZero];
    [filterWords removeAllObjects];
    self.window.rootViewController = viewController;
}

-(void)sortLocation {
    
}

-(void)sortAlphabetically {
    
}

-(void)filterStrings:(NSArray *)filters {
	list = [viewController getList];
    [filteredList removeAllObjects];
    for (int i=0; i < [filters count]; i++) {
		NSString *temp = [filters objectAtIndex:i];
		if ([filterWords containsObject:temp]) {
			[filterWords removeObject:temp];
		}
		else {
			[filterWords addObject:temp];
		}
	}
	//Handle which bars to add based on filterWords to filteredList
    for (int i=0; i < [list count]; i++) {
		BOOL found = NO;
		int j = 0;
		while (!found && j < [filterWords count]) {
			NSString *temp = [list objectAtIndex:i];
			if ([temp rangeOfString:[filterWords objectAtIndex:j]].location != NSNotFound) {
				[filteredList addObject:temp];
				found = YES;
			}
			j = j + 1;
		}
	}
}

-(NSMutableArray*)getList {
    if (sortAlphebetically) {
        return list;
    }
    else {
        return locationList;
    }
}

-(NSMutableArray*)getFilteredList {
    return filteredList;
}

-(NSMutableArray*)getFilterWords {
    return filterWords;
}

-(void)animateSplashScreen{
    NSString *urlAnimationTime = [NSString stringWithFormat:@"https://raw.github.com/BistroStudios/Madison-Bar-Specials/master/AnimationTime.txt"];
	NSError *errorTime = nil;
	NSString *timeContents = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlAnimationTime] encoding:NSASCIIStringEncoding error:&errorTime];
	NSArray *timeArray = [timeContents componentsSeparatedByString:@"\n"];
	NSString *timeText = [timeArray objectAtIndex:0];
    //number of characters in file = number of seconds to display
    animationTime = [timeText length];
    
    if (animationTime != 0) {
        //fade time
        CFTimeInterval animation_duration = animationTime;
        
        //load image
        NSString *day = [[viewController dayReturn] stringByAppendingString:@".png"];
        NSString *imageURL = [@"https://github.com/BistroStudios/Madison-Bar-Specials/raw/master/image" stringByAppendingString:day];
        UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        
        //SplashScreen 
        UIImageView * splashView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)]autorelease];
        splashView.image = tempImage;
        [window addSubview:splashView];
        [window bringSubviewToFront:splashView];
        
        //Animation (fade away with zoom effect)
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animation_duration];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
        [UIView setAnimationDelegate:splashView]; 
        [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
        splashView.alpha = 0.0;
        splashView.frame = CGRectMake(-30, -30, 370, 540);
        
        [UIView commitAnimations];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    exit(0);
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    exit(0);
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

-(void)switchToView1:(UIView *)fromView {
	[fromView removeFromSuperview];
    [viewController customLoadComponents];
	[window addSubview:viewController.view];
}

-(void)switchToView2:(UIView *)fromView {
	[fromView removeFromSuperview];
	[window addSubview:view2Controller.view];
}

-(void)switchToView3:(UIView *)fromView {
	[fromView removeFromSuperview];
	[window addSubview:view3Controller.view];
}

-(void)switchToView4:(UIView *)fromView {
    self.window.rootViewController = self.view4Controller;
}

-(void)switchToView5:(UIView *)fromView {
    self.window.rootViewController = self.view5Controller;
}

-(BOOL)useCustomDay: (BOOL)change {
	if (change) {
		customDayOn = TRUE;
	}
	return customDayOn;
}

-(void)dayToUse: (NSString *) currentDay {
	customDay = currentDay;
}

-(NSString*)getCustomDay {
	return customDay;
}

-(PickerViewViewController*)getPickerInstance {
	return viewController;
}

- (void)dealloc {
    [[GANTracker sharedTracker] stopTracker];
    [viewController release];
	[view2Controller release];
	[view3Controller release];
    [view4Controller release];
    [window release];
    [list release];
    [filterWords release];
    [filteredList release];
    [super dealloc];
    exit(0);
}


@end
