#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MyPinAnnotationView : MKPinAnnotationView{
	NSString *description;
	
}

@property (nonatomic, retain) NSString *description;

@end
