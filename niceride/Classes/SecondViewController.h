//
//  SecondViewController.h
//  niceride
//
//  Created by Ed Williams on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcelltechAppsController.h"
@class ExcelltechAppsController;

@interface SecondViewController : UIViewController {

	
	ExcelltechAppsController *appViewController;
	
	IBOutlet UILabel *startLabel;

	IBOutlet UILabel *timerLabel;

	IBOutlet UILabel *minuteLabel;
	IBOutlet UIButton *leftBut;
	IBOutlet UIButton *rightBut;
	
	IBOutlet UILabel *top;
	IBOutlet UILabel *bot;
	
	
	
	
	NSDate *checkInDate;
	NSTimer *updateTimer;
	
	BOOL tripInProgress;
	
	
	int minutes;
	
	BOOL alerted;
	
	int updateCount;
	
}
- (void) checkAlertedInBackground;
- (IBAction) startTimer;
- (IBAction) leftArrow;
- (IBAction) rightArrow;
- (IBAction) niceRideSite;
- (IBAction) excelltechApps;

- (void) update;
- (void) setupView;


@property BOOL alerted;

@property (nonatomic, retain) ExcelltechAppsController *appViewController;

@property int minutes;
@property BOOL tripInProgress;
@property (nonatomic, retain) NSDate *checkInDate;
@property (nonatomic, retain) NSTimer *updateTimer;

@property (nonatomic, retain) IBOutlet UILabel *top;
@property (nonatomic, retain) IBOutlet UILabel *bot; 

@property (nonatomic, retain) IBOutlet UIButton *leftBut;
@property (nonatomic, retain) IBOutlet UIButton *rightBut;

@property (nonatomic, retain) IBOutlet UILabel *minuteLabel;
@property (nonatomic, retain) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain) IBOutlet UILabel *startLabel;

@end
