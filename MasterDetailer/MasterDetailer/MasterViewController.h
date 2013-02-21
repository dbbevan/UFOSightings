//
//  MasterViewController.h
//  MasterDetailer
//
//  Created by zhou Yangbo on 13-2-21.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController
{
    NSMutableArray *_sightings;
}
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic,retain) NSMutableArray *sightings;

@end
