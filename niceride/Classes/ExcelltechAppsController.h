//
//  ExcelltechAppsController.h
//  Fake-An-Excuse
//
//  Created by Ed Williams on 3/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExcelltechAppsController : UIViewController <UITableViewDelegate> {

	IBOutlet UITableView *appTable;
	
	
}
@property (nonatomic, retain) IBOutlet UITableView *appTable;

- (IBAction) done;
@end
