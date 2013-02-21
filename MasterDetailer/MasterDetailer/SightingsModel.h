//
//  SightingsModel.h
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllSightingsVO.h"

@interface SightingsModel : NSObject
{}

+(SightingsModel *)sharedInstance;

//SightingVOs
+(AllSightingsVO *)getAllSightings;
+(void)setAllSightings:(AllSightingsVO *)value;

@end
