//
//  AllSightingsLayer.h
//  UFOSightings
//
//  Created by zhou Yangbo on 13-2-20.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import <UIKit/UIKit.h>

@interface AllSightingsLayer : CCLayer <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *listData;
}
@property(nonatomic,retain) NSArray *listData;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@end
