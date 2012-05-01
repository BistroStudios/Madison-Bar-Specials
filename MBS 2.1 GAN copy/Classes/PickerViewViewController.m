//
//  PickerViewViewController.m
//  PickerView
//
//  Created by Bistro Studios on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PickerViewViewController.h"
#import "PickerViewAppDelegate.h"
#import "GANTracker.h"

static const NSInteger kGANDispatchPeriodSec = 10;

PickerViewAppDelegate *appDelegate;

@implementation PickerViewViewController

-(double)getLastUpdated{
    return lastUpdated;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView{
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger count;
	if (useFilter) {
		count = [filteredList count];
	}
	else {
		count = [list count];
	}
	return count;
}

-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSArray *arrayBars;
	NSString *nameOfBar;
	if (useFilter) {
		arrayBars = [[filteredList objectAtIndex:row] componentsSeparatedByString:@"\n"];
		nameOfBar = [arrayBars objectAtIndex:0];
	}
	else {
		arrayBars = [[list objectAtIndex:row] componentsSeparatedByString:@"\n"];
		nameOfBar = [arrayBars objectAtIndex:0];
	}
	return nameOfBar;
}

-(IBAction)toView2:(id)sender {
    NSError *error;    
    if (![[GANTracker sharedTracker] trackPageview:@"/Filters Used"
                                         withError:&error])
    {
        // Handle error here
    }
    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.lastRow = [NSString stringWithFormat:@"%d", lastRow];
	[appDelegate switchToView2:self.view];
}

-(IBAction)toView3:(id)sender {
    NSError *error;    
    if (![[GANTracker sharedTracker] trackPageview:@"/Day Changed"
                                         withError:&error])
    {
        // Handle error here
    }
	appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.lastRow = [NSString stringWithFormat:@"%d", lastRow];
	[appDelegate switchToView3:self.view];
}

-(void)toView4:(id)sender {
	appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate switchToView4:self.view];
}

-(void)toView5:(id)sender {
	appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate switchToView5:self.view];
}

-(IBAction)toMaps:(id)sender {
    NSError *error;
    NSString *whichBarMapped = [@"Mapped - " stringByAppendingString:currentBarName];
    if (![[GANTracker sharedTracker] trackPageview:whichBarMapped withError:&error])
    {
        // Handle error here
    }
    NSString *temp = [latsLongs objectForKey:currentBarName];
    NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@",
                     [temp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    /*NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@",
                     [[currentBarName stringByAppendingString:@" near Madison, WI"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];*/
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)applyFilter:(BOOL)allFiltersOff {
    appDelegate = [[UIApplication sharedApplication] delegate];
    filteredList = [appDelegate getFilteredList];
    int numFilteredList = [filteredList count];
    if (numFilteredList == 0) {
		useFilter = FALSE;
        if (!allFiltersOff) {
            UIAlertView *myAlert2 = [[UIAlertView alloc] initWithTitle:@"No bars found" message:@"No bars were found with your current filtering options, so all bars are displayed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [myAlert2 autorelease];
            [myAlert2 show];
        }
	}
	else {
		useFilter = TRUE;
	}
}

-(void)removeFilter {
	useFilter = FALSE;
}

-(NSMutableArray*)getList {
    //appDelegate = [[UIApplication sharedApplication] delegate];
    //return [appDelegate getList];
    return list;
}

-(NSString *)dayReturn{
	appDelegate = [[UIApplication sharedApplication] delegate];
	if (appDelegate.customDay == nil) {
	NSDateFormatter* theDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[theDateFormatter setDateFormat:@"EEEE"];
	appDelegate.customDay = [theDateFormatter stringFromDate:[NSDate date]];
	NSDate *date = [NSDate date];
	NSString *timePart = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
	NSString *hour;
	if ([timePart rangeOfString:@"AM"].location != NSNotFound) {
		NSArray *timeArray = [timePart componentsSeparatedByString:@":"];
		hour = [timeArray objectAtIndex:0];
		if (([hour rangeOfString:@"1"].location != NSNotFound || [hour rangeOfString:@"2"].location != NSNotFound) && ([hour rangeOfString:@"10"].location == NSNotFound && [hour rangeOfString:@"11"].location == NSNotFound)){
			if ([appDelegate.customDay isEqualToString:@"Sunday"]) {
				appDelegate.customDay = @"Saturday";
			}
			else if ([appDelegate.customDay isEqualToString:@"Monday"]) {
				appDelegate.customDay = @"Sunday";
			}
			else if ([appDelegate.customDay isEqualToString:@"Tuesday"]) {
				appDelegate.customDay = @"Monday";
			}
			else if ([appDelegate.customDay isEqualToString:@"Wednesday"]) {
				appDelegate.customDay = @"Tuesday";
			}
			else if ([appDelegate.customDay isEqualToString:@"Thursday"]) {
				appDelegate.customDay = @"Wednesday";
			}
			else if ([appDelegate.customDay isEqualToString:@"Friday"]) {
				appDelegate.customDay = @"Thursday";
			}
			else if ([appDelegate.customDay isEqualToString:@"Saturday"]) {
				appDelegate.customDay = @"Friday";
			}
			else {
				appDelegate.customDay = @"error";
			}
		}
	}
    }
	return appDelegate.customDay;
}

-(void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    appDelegate = [[UIApplication sharedApplication] delegate];
	lastRow = row;
	[self customSelector];
}

-(void)setLastRowZero{
    lastRow = 0;
}

- (void)customSelector {
    NSString *weekDay = [self dayReturn];
    NSString *nameOfBar;
	if (!useFilter) {
		NSArray *arrayBars = [[list objectAtIndex:lastRow] componentsSeparatedByString:@"\n"];
		nameOfBar = [arrayBars objectAtIndex:0];
		NSString *string = @"";
		for (int i = 1; i < [arrayBars count]; i++) {
			if ([[arrayBars objectAtIndex:i] rangeOfString:@"Madison,"].location == NSNotFound) {
                string = [string stringByAppendingString:[arrayBars objectAtIndex:i]];
                string = [string stringByAppendingString:@"\n"];
            }
		}
        NSRange r = [nameOfBar rangeOfString:@"-"];
        if (isFeatured && r.location != NSNotFound) {
            int loc = (int) r.location;
            nameOfBar = [nameOfBar substringToIndex:loc];
        }
        pickLabel.text = nameOfBar;
        specialsLabel.text = string;
		dateLabel.text = weekDay;
        currentBarName = nameOfBar;
	}
	else {
		NSArray *arrayBars = [[filteredList objectAtIndex:lastRow] componentsSeparatedByString:@"\n"];
		nameOfBar = [arrayBars objectAtIndex:0];
		NSString *string = @"";
		for (int i = 1; i < [arrayBars count]; i++) {
			if ([[arrayBars objectAtIndex:i] rangeOfString:@"Madison,"].location == NSNotFound) {
                string = [string stringByAppendingString:[arrayBars objectAtIndex:i]];
                string = [string stringByAppendingString:@"\n"];
            }
		}
		
        pickLabel.text = nameOfBar;
		specialsLabel.text = string;
		dateLabel.text = weekDay;
        currentBarName = nameOfBar;
	}    
    NSError *error;
    if (![[GANTracker sharedTracker] trackEvent:@"bar_stats" action:@"bar_selected" label:nameOfBar value:-1 withError:&error])
    {
        //handle error
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFeatured = FALSE;
    
    [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-28203462-1" dispatchPeriod:kGANDispatchPeriodSec delegate:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    internetReachable = [[Reachability reachabilityForInternetConnection] retain];
    [internetReachable startNotifier];
    hostReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
    [hostReachable startNotifier];
    
    [self checkNetworkStatus:(NSNotification *) nil];    
    
    if (!internetActive)
    {
        NSError *error;    
        if (![[GANTracker sharedTracker] trackPageview:@"/No Internet Found" withError:&error])
        {
            // Handle error here
        }
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"No internet connection" message:@"A connection to the internet is required to download bar specials" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [myAlert autorelease];
        [myAlert show];
        [self toView4:self.view];
    }
    else {
        NSError *error = nil;
        NSString *urlUpdate = [NSString stringWithFormat:@"https://raw.github.com/BistroStudios/Madison-Bar-Specials/master/iPhoneUpdateMessageVersion2Point1.txt"];
        NSString *updateMessage = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlUpdate] encoding:NSASCIIStringEncoding error:&error];
        if ([updateMessage length] != 0) {
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Update Required" message:@"An update to Madison Bar Specials has been released, please download the update to continue to the bar specials" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [myAlert autorelease];
            [myAlert show];
        }        
        filteredList = [[NSMutableArray alloc] init];
        filterWords = [[NSMutableArray alloc] init];
        NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
        [dateF setDateStyle:NSDateFormatterFullStyle];
        NSDate *todayDate = [dateF dateFromString:@"5-MAY-2011 00:00:00 +0000"];
        lastUpdated = [todayDate timeIntervalSince1970];
        
        latsLongs = [[NSMutableDictionary alloc] init];
        [self customLoadComponents];
    }
}

- (void)customLoadComponents {
    
    NSError *error = nil;
    appDelegate = [[UIApplication sharedApplication] delegate];
    filteredList = [appDelegate getFilteredList];
    filterWords = [appDelegate getFilterWords];
    if (appDelegate.fileContents == nil) {
        NSString *url = [NSString stringWithFormat:@"https://raw.github.com/BistroStudios/Madison-Bar-Specials/master/SpecialsMaster.txt"];
        appDelegate.fileContents = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSASCIIStringEncoding error:&error];
    }
	NSArray * tempArray = [[NSArray alloc] init];
    tempArray = [appDelegate.fileContents componentsSeparatedByString:@"\n"];
    barsTabs = [[NSMutableArray alloc] init];
    barsTabs = [tempArray mutableCopy];
    
    list = [[NSMutableArray alloc] init];
	NSMutableArray *bars = [[NSMutableArray alloc] initWithObjects:nil];
	
	NSString *weekDay = [[self dayReturn] stringByAppendingString:@"**"];
	
	int start = 0;
	while ([[barsTabs objectAtIndex:start] rangeOfString:weekDay].location == NSNotFound){
		start++;
	}
	int end = start+1;
	while (end < [barsTabs count] && [[barsTabs objectAtIndex:end] rangeOfString:@"**"].location == NSNotFound) {
		end++;
	}
    isFeatured = TRUE;
    lats = [[NSMutableArray alloc] init];
    longs = [[NSMutableArray alloc] init];
	for (int j=start; j < end; j++) {
        NSString *str = [barsTabs objectAtIndex: j];
		if ([str rangeOfString:@"**"].location != NSNotFound){}
		else if ([str rangeOfString:@"none"].location != NSNotFound){
            isFeatured = FALSE;
        }
		else if ([str isEqualToString:@""]){}
		else {
			NSArray *components = [str componentsSeparatedByString:@"\t"];
            NSString *barName = [components objectAtIndex:0];
            NSString *key = barName;
            if ((j == start + 1) && isFeatured) {
                barName = [barName stringByAppendingString:@" - Featured"];
            }
			NSString *tempSpecials = [barName stringByAppendingString:@"\n"];

			NSString *tempLong;
            NSString *tempLat;
            for (int icomp = 1; icomp < [components count]; icomp++) {
				if ([[components objectAtIndex:icomp] rangeOfString:@"43."].location != NSNotFound){
                    tempLat = [components objectAtIndex:icomp];
                }
				else if ([[components objectAtIndex:icomp] rangeOfString:@"89."].location != NSNotFound){
                    tempLong = [components objectAtIndex:icomp];
                }
				else if ([components objectAtIndex:icomp] != @""){
					tempSpecials = [tempSpecials stringByAppendingString:[components objectAtIndex:icomp]];
					tempSpecials = [tempSpecials stringByAppendingString:@"\n"];
				}
                
			}
			[bars addObject:tempSpecials];	
            [lats addObject:tempLat];
            [longs addObject:tempLong];
            NSString *tempLatLong = [[tempLat stringByAppendingString:@","] stringByAppendingString:tempLong];
            [latsLongs setObject:tempLatLong forKey:key];
        }
	}
	
	int i = [bars count];
	for (int j=0; j<i; j++) {
		[list addObject:[bars objectAtIndex: j]];
	}
	
	NSString *urlCab = [NSString stringWithFormat:@"https://raw.github.com/BistroStudios/Madison-Bar-Specials/master/CabMessage.txt"];
	NSError *errorCab = nil;
	NSString *cabContents = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlCab] encoding:NSASCIIStringEncoding error:&errorCab];
	NSArray *cabArray = [cabContents componentsSeparatedByString:@"\n"];
	NSString *cabText = [cabArray objectAtIndex:0];
	cabMessage.text = cabText;
    lastRow = 0;
	[self customSelector];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
    [list release];
    [filterWords release];
    [filteredList release];
    [lats release];
    [longs release];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void)checkNetworkStatus:(NSNotification *)notice {
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            internetActive = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            internetActive = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            internetActive = YES;
            break;
        }
    }
}

-(void)shouldSortByLocation:(BOOL)shouldSortByLoc {
    sortByLocation = shouldSortByLoc;
}

- (void)dealloc {
    [super dealloc];
    [[GANTracker sharedTracker] stopTracker];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
