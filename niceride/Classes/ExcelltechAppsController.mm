//
//  ExcelltechAppsController.m
//  Fake-An-Excuse
//
//  Created by Ed Williams on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExcelltechAppsController.h"
#import "nicerideAppDelegate.h"

@implementation ExcelltechAppsController

@synthesize appTable;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

	return 65;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {
				case 0:
					
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/fake-a-text/id297082244?mt=8"]];
					break;
				case 1:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/fake-a-location/id369968585?mt=8"]];

					break;
					
				case 2:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/fake-an-excuse-hangup-now/id299879416?mt=8"]];
					break;
					
				case 3:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/fake-a-bank-account/id315188386?mt=8"]];

				default:
					break;
					
			}
			
			break;
		case 1:
			switch (indexPath.row) {
				case 0:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/emf-detector/id320832296?mt=8"]];


					break;
				case 1:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/sleep-analyzer/id296266786?mt=8"]];

					break;
					
				case 2:
					
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/ringing-relief-pro/id348791062?mt=8"]];


					break;
				case 3:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/bird-spot/id325360533?mt=8"]];
					break;
				case 4:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/compass-pointmethere-gps/id294174325?mt=8"]];
					break;
					
				default:
					break;
					
			}

			break;
		case 2:
			switch (indexPath.row) {
				case 0:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/snake-game-boa-constrictor/id304436517?mt=8"]];

					break;
				case 1:
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"itms-apps://itunes.apple.com/us/app/smarter-than-einstein/id316243883?mt=8"]];

					break;
					
				default:
					break;
					
			}
			break;
		default:
			break;
	}
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger i = 0;
	
	switch (section) {
		case 0:
			i= 4;
			break;
		case 1:
			i= 5;
			break;
		case 2:
			i= 2;
			break;
		default:
			break;
	}
	return i;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
	
    if (cell == nil) {
		
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
		
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
	
	switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {

					break;
				case 0:
					cell.textLabel.text = @"Fake-A-Text"; //
					cell.detailTextLabel.text = @"Fake text messages!";
					cell.imageView.image = [UIImage imageNamed:@"fat57.png"];
					break;
				case 1:
					cell.textLabel.text = @"Fake-A-Location";
					cell.detailTextLabel.text = @"Fake GPS coordinates!";
					cell.imageView.image = [UIImage imageNamed:@"fal.png"];
					break;

				case 2:
					cell.textLabel.text = @"Fake-An-Excuse";
					cell.detailTextLabel.text = @"Fake ambient sounds!";
					cell.imageView.image = [UIImage imageNamed:@"57fae.png"];
					break;
				case 3:
					cell.textLabel.text = @"Fake-A-Bank Account";
					cell.detailTextLabel.text = @"Fake money!";
					cell.imageView.image = [UIImage imageNamed:@"57fab.png"];
				default:
					break;
					
			}
			break;
		case 1:
			switch (indexPath.row) {

				case 0:
					cell.textLabel.text = @"EMF Detector";//
					cell.detailTextLabel.text = @"Explore magnetism and electricity with your 3GS";
					cell.imageView.image = [UIImage imageNamed:@"emficon.png"];
					break;

				case 1:
					cell.textLabel.text = @"Sleep Analyzer";  //
					cell.detailTextLabel.text = @"Find out if you really do snore";
					cell.imageView.image = [UIImage imageNamed:@"sleepicon.png"];
					break;
				case 2:
					cell.textLabel.text = @"Ringing Relief Pro";//
					cell.detailTextLabel.text = @"Cure the ringing in your ears!";
					cell.imageView.image = [UIImage imageNamed:@"ringicon.png"];
					break;
					
				case 3:
					cell.textLabel.text = @"Bird Spot (Free)";//
					cell.detailTextLabel.text = @"Share your bird sightings, seek others!";
					cell.imageView.image = [UIImage imageNamed:@"birdicon.png"];
					break;
				case 4:
					cell.textLabel.text = @"Compass PointMeThere GPS";//
					cell.detailTextLabel.text = @"Find your bearing and home with your iPhone";
					cell.imageView.image = [UIImage imageNamed:@"gpsicon.png"];
					break;
					
					
				default:
					break;
					
			}
			
			break;
		case 2:
			switch (indexPath.row) {
					
					cell.textLabel.text = @"Boa Constrictor";
					cell.detailTextLabel.text = @"The evolution of the classic snake game";
					cell.imageView.image = [UIImage imageNamed:@"boaicon.png"];
					break;
					
				case 2:
					cell.textLabel.text = @"Smarter Than Einstein";
					cell.detailTextLabel.text = @"Can you solve the logic puzzle?";
					cell.imageView.image = [UIImage imageNamed:@"einicon.png"];
					
					


				default:
					break;
					
			}
			break;
		default:
			break;
	}
	cell.detailTextLabel.textColor = [UIColor blackColor];
	return cell;
	
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
	return FALSE;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	
	return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	NSString *ret;
	
	switch (section) {
		case 0:
			ret = @"Fake-A™ Products";
			break;
		case 1:
			ret = @"Other Utilities";
			break;
		case 2:
			ret = @"Games";
			break;
		default:
			break;
	}
	return	ret;
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void) done{
	
	[(nicerideAppDelegate *) [[UIApplication sharedApplication] delegate] dismissApps];
	
}

@end
