//
//  DayView.h
//  PickerView
//
//  Created by Bistro Studios on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayView : UIViewController {
	IBOutlet UIPickerView *dayPicker;
	NSMutableArray *arrayDays;
	NSString *currentDay;
	
}

-(IBAction)submitDay:(id)sender;
-(IBAction)unsubmitDay:(id)sender;
@end
