//
//  MapTestViewController.h
//  MapTest
//
//  Created by Ed Williams on 11/16/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTestViewController : UIViewController <MKMapViewDelegate> {

	IBOutlet MKMapView *mapView;
	
	
}

@end

