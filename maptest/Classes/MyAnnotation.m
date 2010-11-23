//
//  MyAnnotation.m
//  geocache
//
//  Created by Ed Williams on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate,t,created,description,date,bikes,emptydocks;
@synthesize  locked;
@synthesize  installed;
@synthesize  temporary;
-(id)initWithCoordinate:(CLLocationCoordinate2D)_cord:(NSString *) tit:(NSString *)descrip :(NSString *) create:(int) b: (int) d;
{
	if([self init])
	{
		bikes = b;
		emptydocks = d;
		coordinate = _cord;
		[self	 setCreated:[NSDate date]];
		[self setT:tit];
		[self setDescription:@"fdsafDAS"];
		[self setDate:[NSDate date]];
	}
	return self;
}

- (NSString *)title{
	return  t;
}
- (NSString *)subtitle{
	
	NSString *s = [NSString stringWithFormat:@"Bikes available: %i    Docks available: %i",bikes,bikes+emptydocks];
	
/*	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setLocale:[NSLocale currentLocale]];
	[df setDateStyle:NSDateFormatterMediumStyle];
	[df setTimeStyle:NSDateFormatterMediumStyle];
	
	NSString *ret = [df stringFromDate:[self date]];
	[df release];
	*/
	return s;

}


@end
