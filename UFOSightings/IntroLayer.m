//
//  IntroLayer.m
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-19.
//  Copyright GODPAPER 2013年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"

#import "Constants.h"
#import "JSONKit.h"
#import "AllSightingsVO.h"
#import "SightingsModel.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
        // API JSON data request
//        [self APIinitilization];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
}

-(void)APIinitilization
{
    NSString *fullURL = INFO_CHIMPS_DOMAIN;
    fullURL = [fullURL stringByAppendingFormat: INFO_CHIMPS_API_KEY, INFO_CHIMPS_API_Q, INFO_CHIMPS_API_REQ_FROM, INFO_CHIMPS_API_REQ_LIMIT];
    NSLog(@"fullURL:%@",fullURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
    NSURLResponse *response;
    NSError *error;
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *jsonKitData = [jsonData objectFromJSONData];
    NSEnumerator *enumerator = [jsonKitData keyEnumerator];
    id key;
    while ((key = [enumerator nextObject]))
    {
        NSLog(@"%@", [jsonKitData objectForKey: key]);
    }
    // Pretend like you've called a REST service here and it returns a string.
    // We'll just create a string from the sample json constant at the top
    // of this file.
    NSString *jsonKitStr = [jsonKitData JSONString];
    //    NSLog(@"string from JSONKit: \n%@", jsonKitStr);
    // 1) Create a dictionary, from the result string,
    // using JSONKit's NSString category; objectFromJSONString.
    NSDictionary* dict = [jsonKitStr objectFromJSONString];
    
    // 2) Dump the dictionary to the debug console.
    NSLog(@"Dictionary => %@\n", dict); 
    
    // 3) Now, let's create a Person object from the dictionary.
    AllSightingsVO* allSightingsVO = [[AllSightingsVO alloc] initWithDictionary:dict];
    
    // 4) Dump the contents of the person object
    // to the debug console.
    NSLog(@"AllSightingsVO => %@\n", allSightingsVO);
    NSLog(@"AllSightingsVO.total: %@\n", [allSightingsVO total]);
    
    // 5) Model store
    [SightingsModel setAllSightings:allSightingsVO];
}
@end
