//
//  FilterView.h
//  PickerView
//
//  Created by Bistro Studios on 10/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface FilterView : UIViewController {
	BOOL beerFilterOn;
    BOOL oneDollarFilterOn;
    BOOL foodFilterOn;
    BOOL shotsFilterOn;
    BOOL pitchersFilterOn;
    BOOL mixersFilterOn;
    BOOL bombsFilterOn;
    BOOL halfOffFilterOn;
    BOOL noveltyFilterOn;
    BOOL under3DollarsFilterOn;
    BOOL twoForOneFilterOn;
	NSArray *beerWords;
	NSArray *oneDollarWords;
    NSArray *foodWords;
    NSArray *shotsWords;
    NSArray *pitchersWords;
    NSArray *mixersWords;
    NSArray *bombsWords;
    NSArray *halfOffWords;
    NSArray *noveltyWords;
    NSArray *under3DollarsWords;
    NSArray *twoForOneWords;
    BOOL allFiltersOff;
}

-(IBAction)switchBeerButton:(id)sender;
-(IBAction)switchOneDollarButton:(id)sender;
-(IBAction)switchFoodButton:(id)sender;
-(IBAction)switchShotsButton:(id)sender;
-(IBAction)switchPitchersButton:(id)sender;
-(IBAction)switchMixersButton:(id)sender;
-(IBAction)switchBombsButton:(id)sender;
-(IBAction)switchHalfOffButton:(id)sender;
-(IBAction)switchNoveltyButton:(id)sender;
-(IBAction)switchUnder3DollarsButton:(id)sender;
-(IBAction)switchTwoForOneButton:(id)sender;
//-(IBAction)toView1:(id)sender;
-(IBAction)submitFilter:(id)sender;
-(IBAction)unsubmitFilter:(id)sender;
-(IBAction)sortByClosest:(id)sender;

@end
