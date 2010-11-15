    //
//  MainViewController.m
//  niceride
//
//  Created by Ed Williams on 7/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "nicerideAppDelegate.h"
#import "MyPinAnnotationView.h"
#import "MyAnnotation.h"
@implementation MainViewController

@synthesize first,mapView,curLocation,locManager;


- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
	
	if(error != nil){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Could not update map tile information. Please check your internet connectivity and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	
	NSLog(@"hit");
	
	
	/*
	
	MyAnnotation *ma = (MyAnnotation *) [view annotation];
	
	
	
	
	[self presentModalViewController:crimeViewController animated:YES];
	
	[[[self crimeViewController] crimeTitle] setText:[ma title]];
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setLocale:[NSLocale currentLocale]];
	
	[df setDateStyle:NSDateFormatterMediumStyle];
	[df setTimeStyle:NSDateFormatterMediumStyle];
	
	[[[self crimeViewController] date] setText:[df stringFromDate:[ma date]]];
	[df release];
	
	[[[self crimeViewController] crimeDescription] setText:[ma description]];
	
	*/
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	if( annotation == [mapView userLocation] ) {
		
		return nil;
		
	}else if (  [(MyAnnotation *) annotation locked]){  //red if locked
		static NSString *annotationViewID = @"AnnotationViewID1";
		
		//	NSLog(@"getting view for annotation: %@",[annotation title]);
		
		MKAnnotationView *mkav = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
		//	MyPinAnnotationView *mkav = (MyPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
		if (mkav == nil) {
			
			//	MyPinAnnotationView  *m = [ [[MyPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			MKAnnotationView *m = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			
			[m setImage:[UIImage imageNamed:@"blocked.png"]];
			//[m setPinColor:MKPinAnnotationColorPurple];
			
			//	[m setAnimatesDrop:YES];
			
			mkav = m;
			
		}
		
		//MyAnnotation *myannotation = (MyAnnotation *) annotation;
		
		//	[mkav setDescription:[myannotation description]];
		
		//	[mkav setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
		
		//UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		//[UIButton buttonWithType:UIButtonTypeCustom];
		//[b setImage:[UIImage imageNamed:@"blocked.png"] forState:UIControlStateNormal];
		//[mkav setRightCalloutAccessoryView:b];
		
		//[mkav setRightCalloutAccessoryView: [[UIImageView alloc] initWithImage:  [UIImage imageNamed:@"blocked.png"]]];
		
		//mkav.rightCalloutAccessoryView = [ UIButtonbuttonWithType: UIButtonTypeDetailDisclosure];
		[mkav setCanShowCallout:YES];
		
		
		
		return mkav;		
	}else if (  [(MyAnnotation *) annotation temporary]){  //special event if temproary
		static NSString *annotationViewID = @"AnnotationViewID2";
		
		//	NSLog(@"getting view for annotation: %@",[annotation title]);
		
		MKAnnotationView *mkav = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
		//	MyPinAnnotationView *mkav = (MyPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
		if (mkav == nil) {
			
			//	MyPinAnnotationView  *m = [ [[MyPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			MKAnnotationView *m = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			
			[m setImage:[UIImage imageNamed:@"special_event.png"]];
			//[m setPinColor:MKPinAnnotationColorPurple];
			
			//	[m setAnimatesDrop:YES];
			
			mkav = m;
			
		}
		
		//MyAnnotation *myannotation = (MyAnnotation *) annotation;
		
		//	[mkav setDescription:[myannotation description]];
		
		//	[mkav setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
		
		//UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		//[UIButton buttonWithType:UIButtonTypeCustom];
		//[b setImage:[UIImage imageNamed:@"blocked.png"] forState:UIControlStateNormal];
		//[mkav setRightCalloutAccessoryView:b];
		
		//[mkav setRightCalloutAccessoryView: [[UIImageView alloc] initWithImage:  [UIImage imageNamed:@"blocked.png"]]];
		
		//mkav.rightCalloutAccessoryView = [ UIButtonbuttonWithType: UIButtonTypeDetailDisclosure];
		[mkav setCanShowCallout:YES];
		
		
		
		return mkav;		
	}
	else if (  ![(MyAnnotation *) annotation installed]){  //upcoming if not installed
		static NSString *annotationViewID = @"AnnotationViewID3";
		
		//	NSLog(@"getting view for annotation: %@",[annotation title]);
		
		MKAnnotationView *mkav = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
		//	MyPinAnnotationView *mkav = (MyPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
		if (mkav == nil) {
			
			//	MyPinAnnotationView  *m = [ [[MyPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			MKAnnotationView *m = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			
			[m setImage:[UIImage imageNamed:@"upcoming.png"]];
			//[m setPinColor:MKPinAnnotationColorPurple];
			
			//	[m setAnimatesDrop:YES];
			
			mkav = m;
			
		}
		
		//MyAnnotation *myannotation = (MyAnnotation *) annotation;
		
		//	[mkav setDescription:[myannotation description]];
		
		//	[mkav setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
		
		//UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		//[UIButton buttonWithType:UIButtonTypeCustom];
		//[b setImage:[UIImage imageNamed:@"blocked.png"] forState:UIControlStateNormal];
		//[mkav setRightCalloutAccessoryView:b];
		
		//[mkav setRightCalloutAccessoryView: [[UIImageView alloc] initWithImage:  [UIImage imageNamed:@"blocked.png"]]];
		
		//mkav.rightCalloutAccessoryView = [ UIButtonbuttonWithType: UIButtonTypeDetailDisclosure];
		[mkav setCanShowCallout:YES];
		
		
		
		return mkav;		
	}
	else{
		
		static NSString *annotationViewID = @"AnnotationViewID";
		
		//	NSLog(@"getting view for annotation: %@",[annotation title]);
		
		MKAnnotationView *mkav = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
	//	MyPinAnnotationView *mkav = (MyPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
		
		if (mkav == nil) {
			
		//	MyPinAnnotationView  *m = [ [[MyPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			MKAnnotationView *m = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID] autorelease];
			
			[m setImage:[UIImage imageNamed:@"activated.png"]];
			//[m setPinColor:MKPinAnnotationColorPurple];
			
			//	[m setAnimatesDrop:YES];
			
			mkav = m;
			
		}
		
		//MyAnnotation *myannotation = (MyAnnotation *) annotation;
		
	//	[mkav setDescription:[myannotation description]];
		
	//	[mkav setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
		
		//UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		//[UIButton buttonWithType:UIButtonTypeCustom];
		//[b setImage:[UIImage imageNamed:@"blocked.png"] forState:UIControlStateNormal];
		//[mkav setRightCalloutAccessoryView:b];

		//[mkav setRightCalloutAccessoryView: [[UIImageView alloc] initWithImage:  [UIImage imageNamed:@"blocked.png"]]];
		
		//mkav.rightCalloutAccessoryView = [ UIButtonbuttonWithType: UIButtonTypeDetailDisclosure];
		[mkav setCanShowCallout:YES];
		
		
		
		return mkav;
		
	}



}

- (void) updateLoc{
	
	CLLocationCoordinate2D loc;
	loc.latitude = curLocation.coordinate.latitude;
	loc.longitude = curLocation.coordinate.longitude;
	
	MKCoordinateRegion region;
	region.center = loc;
	CLLocationDegrees a;
	CLLocationDegrees b;
	a = .02;
	b = .02;
	
	region.span = MKCoordinateSpanMake(a, b);
	
		[[self mapView] setCenterCoordinate:loc];
		[[self mapView] setRegion:region animated:YES];
	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *) oldLocation {
	
	
	
	
	[self setCurLocation:newLocation];
	
	
	///NSDate* newLocationeventDate = newLocation.timestamp;
	//NSTimeInterval howRecentNewLocation = [newLocationeventDate timeIntervalSinceNow];		//if new location older that 5 seconds - quit 
	//if((abs(howRecentNewLocation)>2)){	
		
		
	//	return;		
	//}
	
	
	
	CLLocationCoordinate2D loc;
	loc.latitude = newLocation.coordinate.latitude;
	loc.longitude = newLocation.coordinate.longitude;
	
	MKCoordinateRegion region;
	region.center = loc;
	CLLocationDegrees a;
	CLLocationDegrees b;
	a = .02;
	b = .02;
	
	region.span = MKCoordinateSpanMake(a, b);
	
	if(!first){
		[[self mapView] setCenterCoordinate:loc];
		[[self mapView] setRegion:region animated:YES];
		first = true;
	}
	//[[self mapview[ 
	//[[self mapview] sets
	
	
	
	
}

- (void) showStations{

	nicerideAppDelegate *mainDelegate = (nicerideAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	
	if ([mainDelegate stationEntries]) {
	
		[mapView removeAnnotations:[mapView annotations]];
		
		
		for (NSMutableDictionary *station in [mainDelegate stationEntries]) {
			CLLocationCoordinate2D loc;
			
			loc.latitude = [(NSString *)[station objectForKey:@"lat"] doubleValue];
			loc.longitude = [(NSString *)[station objectForKey:@"long"] doubleValue];
			
			
			
			 
			//MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:loc :(NSString *)[station objectForKey:@"name"] :nil :nil :nil];
			
			MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:loc :(NSString *)[station objectForKey:@"name"]  :nil :[NSDate date] :[(NSString *)[station objectForKey:@"nbBikes"] intValue] :[(NSString *)[station objectForKey:@"nbEmptyDocks"] intValue]  ];
			
			[annotation setInstalled: [ (NSString *) [station objectForKey:@"installed"] boolValue]];
			[annotation setTemporary: [ (NSString *) [station objectForKey:@"temporary"] boolValue]];
			[annotation setLocked:    [ (NSString *) [station objectForKey:@"locked"]    boolValue]];
			
			[annotation setCanShowCallout:YES];
		
			[annotation setImage:[UIImage imageNamed:@"activated.png"]];
			
			[mapView addAnnotation:annotation];
			
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
	
	[[self mapView] setDelegate:self];
	
	CLLocationManager *tmpLocMan = [[CLLocationManager alloc] init];
	[tmpLocMan setDelegate:self];
	[tmpLocMan setDesiredAccuracy:kCLLocationAccuracyBest];
	[self setLocManager:tmpLocMan];
	[tmpLocMan release];
	[[self locManager] startUpdatingLocation];
	
	[mapView setShowsUserLocation:YES];
	
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
