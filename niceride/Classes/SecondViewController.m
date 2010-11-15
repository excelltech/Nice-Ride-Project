    //
//  SecondViewController.m
//  niceride
//
//  Created by Ed Williams on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "nicerideAppDelegate.h"

@implementation SecondViewController
@synthesize leftBut;
@synthesize rightBut,appViewController;

@synthesize minuteLabel;
@synthesize timerLabel;
@synthesize startLabel;

@synthesize top;
@synthesize bot; 
@synthesize checkInDate;
@synthesize updateTimer;
@synthesize tripInProgress,minutes,alerted;

- (IBAction) startTimer{
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	
	if(tripInProgress){
		
		[timerLabel setText:@" -- "];
	
		[startLabel setText:@"Start ride timer"];
		tripInProgress = NO;
		
		[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
	}
	else{
	
		alerted = FALSE;
		
		[startLabel setText:@"End ride timer"];
		tripInProgress = YES;
		[self setCheckInDate:[NSDate dateWithTimeIntervalSinceNow:60 * 30]];
	
		
		[NSKeyedArchiver archiveRootObject:checkInDate toFile:[documentsDirectory stringByAppendingPathComponent:@"checkintime"]];

		[[UIApplication sharedApplication] setIdleTimerDisabled:YES];

	}
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

	[prefs setBool:tripInProgress forKey:@"inprogress"];
	
}


- (void) setupView{
	updateCount = 0;
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	BOOL started = [prefs boolForKey:@"inprogress"];
	[self setTripInProgress:started];
	[self setMinutes:[prefs integerForKey:@"minutes"]];
	[self setUpdateTimer:[NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(update) userInfo:nil repeats:YES]];

	if(tripInProgress){
		
		
		[self setCheckInDate:[NSKeyedUnarchiver unarchiveObjectWithFile:[documentsDirectory stringByAppendingPathComponent:@"checkintime"]]];
	
		[startLabel setText:@"End ride timer"];
		
		
		
	}
	else{
	
		[timerLabel setText:@" -- "];
		[timerLabel setTextColor:[UIColor whiteColor]];
		
	 }
	 
	 
	
	if (! [prefs boolForKey:@"hasRunBefore"] ) {
	
		minutes = 10;
		[prefs setBool:YES forKey:@"hasRunBefore"];
		 
	}
	
	
	if(minutes == 0)
		[minuteLabel setText:@"--"];
	else {
		[minuteLabel setText:[NSString stringWithFormat:@"%i",minutes]];

	}


	
	
	[prefs setInteger:minutes forKey:@"minutes"];

}

- (IBAction) leftArrow{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

	minutes--;
	
	if(minutes < 0)
		minutes = 29;
	
	if(minutes == 0)
		[minuteLabel setText:@"--"];
	else {
		[minuteLabel setText:[NSString stringWithFormat:@"%i",minutes]];
		
	}
	
	
	[prefs setInteger:minutes forKey:@"minutes"];	

	
	if(alerted){
		if (![[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeInterval:(-minutes * 60) sinceDate:checkInDate]] > 0) {  
		
			alerted = FALSE;  //reset alerted if they are lowering time threshold
		}
	}
	
	
	
}

- (IBAction) rightArrow{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

	minutes++;
	
	if(minutes > 29)
		minutes = 0;
	
	if(minutes == 0)
		[minuteLabel setText:@"--"];
	else {
		[minuteLabel setText:[NSString stringWithFormat:@"%i",minutes]];
		
	}
	
	
	[prefs setInteger:minutes forKey:@"minutes"];	
}

- (IBAction) niceRideSite{
	
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.niceridemn.org"]];  

}

- (IBAction) excelltechApps{
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.excelltechmobile.com"]];  
	
}


- (void) checkAlertedInBackground{

	
	if ([[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeInterval:(-minutes * 60) sinceDate:checkInDate]] > 0) {
		alerted = TRUE;
	}

	
}


- (void) update{

	nicerideAppDelegate	*mainDelegate = (nicerideAppDelegate *) [[UIApplication sharedApplication] delegate];

	
	
	updateCount++;
	if(updateCount > (5 * 60) * 3){   // update xml feed every 3 minutes
		
		[mainDelegate updateMap];
		
		
		
	}

	if(tripInProgress){
	
		int time = [checkInDate timeIntervalSinceNow];
		
		int sec;
		int min;
		
		
		if(time > 0){   //checkInDate  is in the future
			min = (int)   floor( (double) time / 60.00  );
		
			sec = time - (min * 60);
			
			[timerLabel setTextColor:[UIColor whiteColor]];
			if (sec < 10) {
				[timerLabel setText:[NSString stringWithFormat:@"%i:0%i",min,sec]];
			}
			else{
				[timerLabel setText:[NSString stringWithFormat:@"%i:%i",min,sec]];

			}
			
			
			
			if ([[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeInterval:(-minutes * 60) sinceDate:checkInDate]] > 0) {
				if(!alerted){
				
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Trip time expires soon" message:[NSString stringWithFormat:@"You have less than %i minutes to check your bike into a dock before incurring overtime fees.",minutes] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		
					[alert show];
					[alert release];
					
				
					alerted = TRUE;
					[mainDelegate playSound];

				}
			}
			
		}
		else{  //checkInDate is in the past 
			
			time = abs(time);
			
			
			min = (int)   floor( (double) time / 60.00  );
			
			sec = time - (min * 60);
			
			[timerLabel setTextColor:[UIColor redColor]];
			if (sec < 10) {
				[timerLabel setText:[NSString stringWithFormat:@"%i:0%i",min,sec]];
			}
			else{
				[timerLabel setText:[NSString stringWithFormat:@"%i:%i",min,sec]];
				
			}			
			
			
			
		}
		
		
		
		
		
	}
	
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
	ExcelltechAppsController *tmp = [[ExcelltechAppsController alloc] initWithNibName:@"apps" bundle:nil];
	[self setAppViewController:tmp];
	[tmp release];
	
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
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
