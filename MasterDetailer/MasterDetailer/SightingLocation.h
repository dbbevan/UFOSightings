//
//  SightingLocation.h
//  MasterDetailer
//
//  Created by zhou Yangbo on 13-2-22.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SightingLocation : NSObject <MKAnnotation>
{
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
}
@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

-(id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate;
@end
