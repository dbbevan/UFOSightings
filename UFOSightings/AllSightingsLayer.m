//
//  AllSightingsLayer.m
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "AllSightingsLayer.h"
#import "CCUIViewWrapper.h"

@implementation AllSightingsLayer
//
@synthesize listData;
//
CCUIViewWrapper *wrapper;
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
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        UIView *myView = [[[UIView alloc] init] autorelease];
        wrapper = [CCUIViewWrapper wrapperForUIView:myView];
        wrapper.contentSize = CGSizeMake(winSize.width, winSize.height);
        wrapper.position = ccp(0,0);
        [self addChild:wrapper];
        //
        NSArray *array = [[NSArray alloc] initWithObjects:@"iPhone",@"iPod",@"iPad", nil];
        self.listData = array;
        [array release];
        //UITableView
        UITableView *tableView = [[UITableView alloc] init];
        [myView addSubview:tableView];
    }
	
	return self;
}

-(void)dealloc
{
    //Clean up
    [self removeChild:wrapper cleanup:YES];
    wrapper = nil;
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
