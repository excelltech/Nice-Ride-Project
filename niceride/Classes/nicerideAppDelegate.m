//
//  nicerideAppDelegate.m
//  niceride
//
//  Created by Ed Williams on 7/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "nicerideAppDelegate.h"
#import "MainViewController.h"
#import "SecondViewController.h"

@implementation nicerideAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize xmlConnection;
@synthesize receivedData,player;

@synthesize stationEntries;
#pragma mark -
#pragma mark Application lifecycle


- (void) playSound{

	

	[player play];
	
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
	
	
	BOOL	alerted = 	[ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] alerted  ];
	BOOL started = [ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1]  tripInProgress ];

	
	if( !alerted && started){
	
	
	[[ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] updateTimer] setFireDate:[NSDate distantFuture]];


		
	[[ (MainViewController *)	[[tabBarController viewControllers] objectAtIndex:0] locManager] stopUpdatingLocation];

		
		
		
		UIApplication* app = [UIApplication sharedApplication];
		
		NSArray*    oldNotifications = [app scheduledLocalNotifications];
		
		
		
		// Clear out the old notification before scheduling a new one.
		
		if ([oldNotifications count] > 0)
			
			[app cancelAllLocalNotifications];
		
		
		
		// Create a new notification
		Class MyUILocalNotification = NSClassFromString(@"UILocalNotification");   
		
		
		UILocalNotification* text = [[[MyUILocalNotification alloc] init] autorelease];
		
		if (text)
			
		{
			
				

			if (![ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] alerted]) {
				
			

				
			
				text.fireDate = [NSDate dateWithTimeInterval:(-[ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] minutes] * 60) sinceDate:[ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] checkInDate]];
			//call.fireDate = [[NSDate date] dateByAddingTimeInterval:10];
			
				text.timeZone = [NSTimeZone defaultTimeZone];
			
				text.repeatInterval = 0;
			
				text.soundName = @"cashregisterx.wav";
			

			
				text.alertBody = [NSString stringWithFormat:@"You have less than %i minutes to check your bike in before you incur overtime fees.",[ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] minutes]];
				
				[app scheduleLocalNotification:text];
			
			

			
			}
			
			
		}
		
	}
		
	

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
	
	NSLog(@"local notification");
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
	
	//[ (MainViewController *)	[[tabBarController viewControllers] objectAtIndex:0] setFirst:YES] ;
	[ (MainViewController *)	[[tabBarController viewControllers] objectAtIndex:0] updateLoc] ;

	[[ (MainViewController *)	[[tabBarController viewControllers] objectAtIndex:0] locManager] startUpdatingLocation];

	
	
	UIApplication* app = [UIApplication sharedApplication];
	
	NSArray*    oldNotifications = [app scheduledLocalNotifications];
	
	
	[(SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] 	checkAlertedInBackground];
	if ([oldNotifications count] > 0)
		
		[app cancelAllLocalNotifications];
	
	

	
	
	[(SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] setUpdateTimer:[NSTimer scheduledTimerWithTimeInterval:.2 target:(SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] selector:@selector(update) userInfo:nil repeats:YES]];

}





- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
	//  NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	
	
	
    // release the connection, and the data object
	
	
	
	
	if (connection == xmlConnection) {
		
		
		
		NSString * responseString =  [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] retain];
		
		responseString =  [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		

		
		// Initialize the blogEntries MutableArray that we declared in the header
		
		if(stationEntries)
			[stationEntries release];
		
		stationEntries = [[NSMutableArray alloc] init];	
		
		// Convert the supplied URL string into a usable URL object
		//NSURL *url = [NSURL URLWithString: blogAddress];
		
		// Create a new rssParser object based on the TouchXML "CXMLDocument" class, this is the
		// object that actually grabs and processes the RSS data
		CXMLDocument *xmlParser = [[[CXMLDocument alloc] initWithXMLString:responseString options:0 error:nil] autorelease];   //[[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
		
		// Create a new Array object to be used with the looping of the results from the rssParser
		NSArray *resultNodes = NULL;
		
		// Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
		resultNodes = [xmlParser nodesForXPath:@"//station" error:nil];
		
		// Loop through the resultNodes to access each items actual data
		for (CXMLElement *resultElement in resultNodes) {
			
			// Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
			NSMutableDictionary *stationItem = [[NSMutableDictionary alloc] init];
			
			// Create a counter variable as type "int"
			int counter;
			
			// Loop through the children of the current  node
			for(counter = 0; counter < [resultElement childCount]; counter++) {
				
				// Add each field to the blogItem Dictionary with the node name as );key and node value as the value
			//	NSLog([[resultElement childAtIndex:counter] name]);
				if([[resultElement childAtIndex:counter] stringValue])
					[stationItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
			}
			
			// Add the blogItem to the global blogEntries Array so that the view can access it.
			[stationEntries addObject:[stationItem copy]];
		}
		
		
		
		
		
		
		[responseString release];
		[connection release];
	//	[receivedData release];
		[self setReceivedData:nil];

		
		[ (MainViewController *)	[[tabBarController viewControllers] objectAtIndex:0] showStations];
		
				
		
		
	}
		
	
	
	
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    
	// release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
  //  [receivedData release];
	
	[self setReceivedData:nil];

    // inform the user
  //  NSLog(@"Connection failed! Error - %@ %@",
   //       [error localizedDescription],
   //       [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Could not establish connection to the Nice Ride MN XML feed. Please verify you are connected to the internet and try again. " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}








- (void) updateMap{
	
	
	NSURL *url = [NSURL URLWithString:@"http://secure.niceridemn.org/data2/bikeStations.xml"];
	
	
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
	

	
	NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
	
	[req setValue:contentType forHTTPHeaderField:@"Content-type"];
	
	//NSData *imageData = UIImagePNGRepresentation(anImage);
	
	// adding the body
	//NSMutableData *postBody = [NSMutableData data];
	
	//NSLog(@"
	//%@",file);
	//[postBody appendData:[[NSString stringWithFormat:@"key=%@",file] dataUsingEncoding:NSUTF8StringEncoding]];
	//[req setHTTPBody:postBody];
	// first parameter an image
	//	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	//	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"upload\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
	//	[postBody appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	//	[postBody appendData:imageData];
	
	// second parameter information
	
	
	//[postBody appendData:[[NSString stringWithFormat:@"voiceorscript=%f&pack=%f&title=%f",0,1,1] dataUsingEncoding:NSUTF8StringEncoding]];
	
	/*
	 [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	 [postBody appendData:[@"Content-Disposition: form-data; name=\"some_other_name\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	 [postBody appendData:[@"some_other_value" dataUsingEncoding:NSUTF8StringEncoding]];
	 [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r \n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	 */
	//[req setHTTPBody:postBody];
	
	
	
	//NSURLResponse* response;
	//NSError* error;
	//NSData* result = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
	
	
	
	
	//	NSURLConnection *tmpConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
	
	[self setXmlConnection:[[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES]];
	//	[self setGetRecentConnection:tmpConnection];
	//	[tmpConnection release];
	if (xmlConnection) {
		
		// Create the NSMutableData that will hold
		
		// the received data
		
		// receivedData is declared as a method instance elsewhere
		[self setReceivedData:[NSMutableData data]];
	//	receivedData=[[NSMutableData data] retain];
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Could not establish connection to the Nice Ride XML feed. Please verify you are connected to the internet and try again. " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
		// inform the user that the download could not be made
		
	}
	
}
- (void) dismissApps{
	[ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] dismissModalViewControllerAnimated:YES ];

	
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	NSBundle *bundle = [NSBundle mainBundle];

	[self setupSecondView];

	AVAudioPlayer *tplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[bundle pathForResource:@"cashregisterx.wav" ofType:nil]] error:nil];

	[self setPlayer:tplayer];
	[tplayer release];
	
	
	[window addSubview:[tabBarController view]];
	
    [window makeKeyAndVisible];
	[self updateMap];
	return YES;
}
- (void) setupSecondView{

	[ (SecondViewController *)	[[tabBarController viewControllers] objectAtIndex:1] setupView];

	
	
	
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}





- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
