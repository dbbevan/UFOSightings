//
//  SightingLocation.m
//  MasterDetailer
//
//  Created by zhou Yangbo on 13-2-22.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "SightingLocation.h"

@implementation SightingLocation

@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

-(id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if ((self=[super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
    }
    return self;
}

-(NSString *)title
{
    if ([_name isKindOfClass:[NSNull class]]) {
        return @"Unkown charge";
    }else {
        return _name;
    }
}

-(NSString *)subtitle
{
    return _address;
}


@end
