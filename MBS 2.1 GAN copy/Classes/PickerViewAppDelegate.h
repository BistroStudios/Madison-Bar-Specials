//
//  PickerViewAppDelegate.h
//  PickerView
//
//  Created by Bistro Studios on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class PickerViewViewController;
@class FilterView;
@class DayView;
@class NoConnectionPage;
@class Update;

@interface PickerViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PickerViewViewController *viewController;
	FilterView *view2Controller;
	DayView *view3Controller;
    NoConnectionPage *view4Controller;
    Update *view5Controller;
	BOOL customDayOn;
	NSString *customDay;
    NSString *fileContents;
    NSString *lastRow;
    NSMutableArray *filteredList;
    NSMutableArray *list;
    NSMutableArray *filterWords;
    BOOL useFilter;
    BOOL filtersOff;
    int animationTime;
    NSMutableArray *locationList;
    NSMutableArray *locationFilteredList;
    BOOL sortAlphebetically;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PickerViewViewController *viewController;
@property (nonatomic, retain) IBOutlet FilterView *view2Controller;
@property (nonatomic, retain) IBOutlet DayView *view3Controller;
@property (nonatomic, retain) IBOutlet NoConnectionPage *view4Controller;
@property (nonatomic, retain) IBOutlet Update *view5Controller;
@property (nonatomic, retain) NSString *customDay;
@property (nonatomic, retain) NSString *fileContents;
@property (nonatomic, retain) NSString *lastRow;
@property (nonatomic, retain) NSMutableArray *filteredList;
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) NSMutableArray *filterWords;
@property (nonatomic, retain) NSMutableArray *locationFilteredList;
@property (nonatomic, retain) NSMutableArray *locationList;


-(void)switchToView1: (UIView *) fromView;
-(void)switchToView2: (UIView *) fromView;
-(void)switchToView3: (UIView *) fromView;
-(void)switchToView4: (UIView *) fromView;
-(void)switchToView5: (UIView *) fromView;
-(PickerViewViewController*)getPickerInstance;
-(BOOL)useCustomDay: (BOOL) change;
-(NSString*)getCustomDay;
-(void)dayToUse: (NSString *) currentDay;
-(void)restartPicker:(BOOL)cancel;
-(void)restartPickerForNewDay;
-(void)animateSplashScreen;
-(void)filterStrings:(NSArray *)filters;
-(NSMutableArray*)getFilteredList;
-(NSMutableArray*)getFilterWords;
-(void)setFiltersBool:(BOOL)allFiltersOff;
-(BOOL)shouldSortByClosest;
-(void)sortBarsByClosest;
-(void)sortBarsAlphebetically;
-(NSMutableArray*)getList;
-(void)sortLocation;
-(void)sortAlphabetically;

@end

