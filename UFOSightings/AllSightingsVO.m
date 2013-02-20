//
//  AllSightingsVO.m
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "AllSightingsVO.h"
#import "SightingVO.h"

@implementation AllSightingsVO
//@see http://www.infochimps.com/datasets/60000-documented-ufo-sightings-with-text-descriptions-and-metada#overview_tab

@synthesize total,results;

+ (Class)results_class {
    return [SightingVO class];
}
@end
