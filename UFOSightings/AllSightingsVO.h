//
//  AllSightingsVO.h
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "Jastor.h"

@interface AllSightingsVO : Jastor
//@see http://www.infochimps.com/datasets/60000-documented-ufo-sightings-with-text-descriptions-and-metada#overview_tab
{}
@property(nonatomic,retain) NSNumber *total;
@property(nonatomic,retain) NSArray *results;
@end
