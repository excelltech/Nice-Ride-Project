//
//  MapTestViewController.m
//  MapTest
//
//  Created by Ed Williams on 11/16/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MapTestViewController.h"
#import "MyAnnotation.h"

@implementation MapTestViewController

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	
	
	if( annotation == [mapView userLocation] ) {
		
		return nil;
		
	}else {  
		static NSString *annotationViewID = @"AnnotationViewID1";
		
				
		MKPinAnnotationView *mkav = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationViewID1"];
		
		
		if (mkav == nil) {
			
			MKPinAnnotationView *m = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID];
			
			[m setPinColor:MKPinAnnotationColorPurple];
			
			//	[m setAnimatesDrop:YES];
			
			mkav = m;
			
		}
		
		if ( [(MyAnnotation *)annotation bikes] == 0) {
			[mkav setPinColor:MKPinAnnotationColorPurple];
		}
		return mkav;
	}
	
	
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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


	[mapView setShowsUserLocation:YES];
	
	
	//// first pin at 0,90
	
	CLLocationCoordinate2D cord;
	cord.latitude = 0.0f;
	cord.longitude = 90.0f;
	
	
	MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:cord :@"Test" :@"test thing" :[NSDate date] :1 :1];
	
	
	[mapView addAnnotation:annotation];

	
	
	// second pin
	
	CLLocationCoordinate2D cord1;
	cord1.latitude = 45.0f;
	cord1.longitude = 95.0f;
	
	
	MyAnnotation *annotation1 = [[MyAnnotation alloc] initWithCoordinate:cord1 :@"Test" :@"test thing" :[NSDate date] :0 :0];
	
	
	[mapView addAnnotation:annotation1];
	
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

@end
