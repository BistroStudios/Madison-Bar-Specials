//
//  PickerViewViewController.h
//  PickerView
//
//  Created by Bistro Studios on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "NoConnectionPage.h"
#import "Update.h"


@class Reachability;

@interface PickerViewViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {

	NSMutableArray *filteredList;
	NSMutableArray *list;
	IBOutlet UILabel *pickLabel;
	IBOutlet UILabel *specialsLabel;
	IBOutlet UILabel *dateLabel;
	IBOutlet UILabel *cabMessage;
    IBOutlet UILabel *sLabel;
	BOOL useFilter;
	NSMutableArray *filterWords;
    NSMutableArray *barsTabs;
    NSInteger lastRow;
    NSInteger remLastRow;
    NSString *latlong;
    NSMutableArray *lats;
    NSMutableArray *longs;
    Reachability *internetReachable;
    Reachability *hostReachable;
    BOOL internetActive;
    BOOL hostActive;
    BOOL isFeatured;
    double lastUpdated;
    BOOL sortByLocation;
    NSString *currentBarName;
    NSMutableDictionary *latsLongs;
}

-(NSString *) dayReturn;
-(IBAction)toView2:(id)sender;
-(IBAction)toView3:(id)sender;
-(void)toView4:(id)sender;
-(void)toView5:(id)sender;
//-(void)filterStrings:(NSArray *)filters;
-(void)applyFilter:(BOOL)allFiltersOff;
-(void)removeFilter;
-(void)customLoadComponents;
- (void)customSelector;
-(IBAction)toMaps:(id)sender;
-(void)checkNetworkStatus: (NSNotification *) notice;
-(double)getLastUpdated;
-(void)setLastRowZero;
-(NSMutableArray*)getList;
-(void)shouldSortByLocation:(BOOL)shouldSortByLoc;

@end

