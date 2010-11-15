//
//  MainViewController.h
//  niceride
//
//  Created by Ed Williams on 7/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKMapView.h>
#import "TouchXML.h"
#import "MyAnnotation.h"

#import <CoreLocation/CoreLocation.h> 
#import <CoreLocation/CLLocationManagerDelegate.h> 

@interface MainViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>{
	CLLocation *curLocation;
	CLLocationManager *locManager;
	IBOutlet MKMapView *mapView;
	BOOL first;
}
- (void) showStations;
- (void) updateLoc;
@property (nonatomic, retain) CLLocationManager *locManager;
@property BOOL first;


@property (nonatomic, retain) CLLocation *curLocation;
@property (nonatomic, retain)  IBOutlet MKMapView *mapView;

@end
