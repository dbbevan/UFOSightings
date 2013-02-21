//
//  SightingVO.h
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "Jastor.h"

@interface SightingVO : Jastor
{

}
//@see http://www.infochimps.com/datasets/60000-documented-ufo-sightings-with-text-descriptions-and-metada#overview_tab
@property(nonatomic,retain) NSString *duration;
@property(nonatomic,retain) NSString *shape;
@property(nonatomic,retain) NSString *location;
@property(nonatomic,retain) NSString *sighted_at;
@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *reported_at;

@end
