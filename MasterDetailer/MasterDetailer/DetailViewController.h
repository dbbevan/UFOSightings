//
//  DetailViewController.h
//  MasterDetailer
//
//  Created by zhou Yangbo on 13-2-21.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SightingVO.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,MKMapViewDelegate>
{
    BOOL _doneInitialZoom;
}

@property (strong, nonatomic) SightingVO *detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailDescriptionTextView;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
