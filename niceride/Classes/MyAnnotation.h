//
//  MyAnnotation.h
//  geocache
//
//  Created by Ed Williams on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : MKAnnotationView <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *t;
	NSString *description;
	NSString *created;
	NSDate *date;
	int bikes;
	int emptydocks;
	BOOL locked;
	BOOL installed;
	BOOL temporary;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)_cord:(NSString *) tit:(NSString *)descrip :(NSString *) create: (int) b : (int) d;
- (NSString *)title;
- (NSString *)subtitle;


@property BOOL locked;
@property BOOL installed;
@property BOOL temporary;
@property int bikes;
@property int emptydocks;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *t;
@property (nonatomic, retain) NSString *description;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end