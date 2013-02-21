//
//  AllSightingsLayer.m
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "AllSightingsLayer.h"
#import "CCUIViewWrapper.h"
#import "TableViewController.h"
#import "SightingsModel.h"

@implementation AllSightingsLayer
//
@synthesize listData;
//
CGSize winSize;
UIView *uiView;
CCUIViewWrapper *uiViewWrapper;
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AllSightingsLayer *layer = [AllSightingsLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {
        winSize = [[CCDirector sharedDirector] winSize];
        //
        uiView = [[[UIView alloc] init] autorelease];
        [uiView setFrame:CGRectMake(0, 0, winSize.width, winSize.height)];
        uiViewWrapper = [CCUIViewWrapper wrapperForUIView:uiView];
        uiViewWrapper.contentSize = CGSizeMake(winSize.width, winSize.height);
        uiViewWrapper.position = ccp(0,0);
        [self addChild:uiViewWrapper];
        //
        //    NSArray *array = [[NSArray alloc] initWithObjects:@"iPhone",@"iPod",@"iPad", nil];
        NSArray *array = [[SightingsModel getAllSightings] results];
        self.listData = array;
        [array release];
        //UITableView
//        TableViewController *tableViewController = [[TableViewController alloc]  initWithStyle:UITableViewStylePlain]; 
         UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain]; 
        CGRect rect = tableViewController.view.frame;
        rect.size.height = winSize.height; //set height whatever you want.
        rect.size.width = winSize.width; //set width whatever you want.
        [UIView beginAnimations:@"TableAnimation" context:NULL];
        [UIView setAnimationDuration:1];
        tableViewController.view.frame = rect;
        [UIView commitAnimations]; 
        //
        [uiView addSubview:tableViewController.view];


    }
	
	return self;
}

-(void)dealloc
{
    //Clean up
    [self removeChild:uiViewWrapper cleanup:YES];
    uiViewWrapper = nil;
    //
    [listData dealloc];
    //
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listData objectAtIndex:row];
    return cell;
    
}

@end
