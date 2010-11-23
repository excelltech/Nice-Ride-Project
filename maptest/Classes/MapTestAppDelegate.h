//
//  MapTestAppDelegate.h
//  MapTest
//
//  Created by Ed Williams on 11/16/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapTestViewController;

@interface MapTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapTestViewController *viewController;

@end

