//
//  DayView.m
//  PickerView
//
//  Created by Bistro Studios on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DayView.h"
#import "PickerViewAppDelegate.h"

@implementation DayView

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
	arrayDays = [[NSMutableArray alloc] init];
	[arrayDays addObject:@"Sunday"];
	[arrayDays addObject:@"Monday"];
	[arrayDays addObject:@"Tuesday"];
	[arrayDays addObject:@"Wednesday"];
	[arrayDays addObject:@"Thursday"];
	[arrayDays addObject:@"Friday"];
	[arrayDays addObject:@"Saturday"];
	
	currentDay = @"Sunday";
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView{
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	return [arrayDays count];
}

-(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [arrayDays objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	currentDay = [arrayDays objectAtIndex:row];	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction)submitDay:(id)sender {
	PickerViewAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	appDelegate.customDay = currentDay;
    [appDelegate useCustomDay:TRUE];
	[appDelegate restartPickerForNewDay];
    //[appDelegate switchToView1:self.view];
}	

-(IBAction)unsubmitDay:(id)sender {
	PickerViewAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	appDelegate.customDay = nil;
	[appDelegate switchToView1:self.view];
}

@end
