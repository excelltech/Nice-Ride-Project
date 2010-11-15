//
//  nicerideAppDelegate.h
//  niceride
//
//  Created by Ed Williams on 7/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TouchXML.h"
#import <AVFoundation/AVFoundation.h>

@interface nicerideAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UITabBarController *tabBarController;
	NSURLConnection *xmlConnection;
	
	NSMutableData *receivedData;
	
	NSMutableArray *stationEntries;
	
	AVAudioPlayer *player;

}

- (void) playSound;

- (void) updateMap;
- (void) dismissApps;
- (void) setupSecondView;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *stationEntries;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSURLConnection *xmlConnection;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) AVAudioPlayer *player;

@end

