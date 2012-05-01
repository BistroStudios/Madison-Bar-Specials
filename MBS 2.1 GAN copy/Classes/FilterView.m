//
//  FilterView.m
//  PickerView
//
//  Created by Bistro Studios on 10/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterView.h"
#import "PickerViewViewController.h"
#import "PickerViewAppDelegate.h"

PickerViewAppDelegate *appDelegate;

@implementation FilterView


- (void)viewDidLoad {
    [super viewDidLoad];
	
	beerFilterOn = FALSE;
    oneDollarFilterOn = FALSE;
    foodFilterOn = FALSE;
    shotsFilterOn = FALSE;
    pitchersFilterOn = FALSE;
    mixersFilterOn = FALSE;
    bombsFilterOn = FALSE;
    halfOffFilterOn = FALSE;
    noveltyFilterOn = FALSE;
    under3DollarsFilterOn = FALSE;
    twoForOneFilterOn = FALSE;
	beerWords = [[NSArray alloc] initWithObjects:@"pint",@"tap",@"PBR",@"eer",@"cans",@"all boy",@"oot",@"liter",@"brew",@"Tall",@"ucket",@"micro",@"silo",@"ong neck",@"Miller",@"Bud",@"Pabst",@"bottle", nil];
    oneDollarWords = [[NSArray alloc] initWithObjects:@"$1 ", nil];
    foodWords = [[NSArray alloc] initWithObjects:@"food", @"aco", @"acon ", @" wing ", @"tater ", @"Wing ", @"wing", @"pizza", @"fish ", @"Fish ", @"fry", @"Fry", @"acho", @"corn", @"Corn", @"urger", @"heese", @"loppy", nil];
    shotsWords = [[NSArray alloc] initWithObjects:@"shot", nil];
    pitchersWords = [[NSArray alloc] initWithObjects:@"pitcher", @"Pitcher", nil];
    mixersWords = [[NSArray alloc] initWithObjects:@"mixer", @"Mixer", @"drink", @"hnorkel", @"Drink", @"sland", @"LIT", @"artini", @"marg", @"rail", @"Rail", @"crewdriver", @"imosa", @"aiquiri", @"ishbowl", @"ou-call-it", @"emonade", @"osmo", @"wampwater", @"ighrise", @"scraper", @"double", nil];
    bombsWords = [[NSArray alloc] initWithObjects:@"omb", nil];
    halfOffWords = [[NSArray alloc] initWithObjects:@"1/2", nil];
    noveltyWords = [[NSArray alloc] initWithObjects:@"bong", @"Bong", @"xchange", @"free", @"Free", @"FREE", @"pool", @"shake", @"ull tabs", @"flip", @"hirt", @"kirt", @"rivia", @"icket", @"ou-can-drink", @"gear", @"Pong", @"pong", @"wheel", @"Wheel", @"dart", @"Dart", nil];
    under3DollarsWords = [[NSArray alloc] initWithObjects:@"$1 ", @"$2 ", @"1.", @"2.", nil];
    twoForOneWords = [[NSArray alloc] initWithObjects:@"2 for 1", @"2-for-1", nil];
    
}



-(IBAction)switchBeerButton:(id)sender {
	//filter to something
	beerFilterOn = !beerFilterOn;
	appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:beerWords];
}

-(IBAction)switchOneDollarButton:(id)sender {
    oneDollarFilterOn = !oneDollarFilterOn;
	appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:oneDollarWords];
}

-(IBAction)switchFoodButton:(id)sender {
    foodFilterOn = !foodFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:foodWords];
}

-(IBAction)switchShotsButton:(id)sender {
    shotsFilterOn = !shotsFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:shotsWords];
}

-(IBAction)switchPitchersButton:(id)sender {
    pitchersFilterOn = !pitchersFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:pitchersWords];
}

-(IBAction)switchMixersButton:(id)sender {
    mixersFilterOn = !mixersFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:mixersWords];
}

-(IBAction)switchBombsButton:(id)sender {
    bombsFilterOn = !bombsFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:bombsWords];
}

-(IBAction)switchHalfOffButton:(id)sender {
    halfOffFilterOn = !halfOffFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:halfOffWords];
}

-(IBAction)switchNoveltyButton:(id)sender {
    noveltyFilterOn = !noveltyFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:noveltyWords];
}

-(IBAction)switchUnder3DollarsButton:(id)sender {
    under3DollarsFilterOn = !under3DollarsFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:under3DollarsWords];
}

-(IBAction)switchTwoForOneButton:(id)sender {
    twoForOneFilterOn = !twoForOneFilterOn;
    appDelegate = [[UIApplication sharedApplication] delegate];
	[appDelegate filterStrings:twoForOneWords];
}
/*-(IBAction)toView1:(id)sender {
	FilterView *appDelegate = (FilterView*)[[UIApplication sharedApplication] delegate];
	[appDelegate switchToView1:self.view];
}*/

-(IBAction)submitFilter:(id)sender {
	PickerViewAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    allFiltersOff = !beerFilterOn && !oneDollarFilterOn && !foodFilterOn && !bombsFilterOn && !pitchersFilterOn && !mixersFilterOn && !bombsFilterOn && !halfOffFilterOn && !noveltyFilterOn && !under3DollarsFilterOn && !twoForOneFilterOn;
    [appDelegate setFiltersBool:allFiltersOff];
    [appDelegate restartPicker:FALSE];
	
}	

-(IBAction)unsubmitFilter:(id)sender {
	PickerViewAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];    
    [appDelegate restartPicker:TRUE];
	PickerViewViewController *picker = [appDelegate getPickerInstance];
    [picker removeFilter];
	[appDelegate switchToView1:self.view];
}

-(IBAction)sortByClosest:(id)sender{
    PickerViewAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate shouldSortByClosest]) {
        [appDelegate sortBarsByClosest];
    }
    else {
        [appDelegate sortBarsAlphebetically];
    }
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
    [beerWords release];
    [oneDollarWords release];
    [foodWords release];
    [shotsWords release];
    [bombsWords release];
    [halfOffWords release];
    [under3DollarsWords release];
    [noveltyWords release];
    [twoForOneWords release];
}


@end
