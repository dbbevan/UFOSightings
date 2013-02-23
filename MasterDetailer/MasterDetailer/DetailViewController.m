//
//  DetailViewController.m
//  MasterDetailer
//
//  Created by zhou Yangbo on 13-2-21.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//
//@see http://www.raywenderlich.com/2847/introduction-to-mapkit-on-ios-tutorial

#import "DetailViewController.h"
#import "JSONKit.h"
#import "SightingLocation.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize detailDescriptionTextView = _detailDescriptionTextView;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize mapView = _mapView;

- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [_detailDescriptionTextView release];
    [_masterPopoverController release];
    [_mapView release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem location];
        self.detailDescriptionTextView.text = [self.detailItem description];
        //MapKit configure here.
        //1
        //
        NSLog(@"Location:%@",[self.detailItem location]);
        NSString *location = [self.detailItem location];
        CLLocationCoordinate2D queryLocation = [self geoCodeUsingAddress:location];
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = queryLocation.latitude;
        zoomLocation.longitude = queryLocation.longitude;
        //Annotation
        SightingLocation *annotation = [[SightingLocation alloc] initWithName:[self.detailItem duration] address:[self.detailItem location] coordinate:zoomLocation];
        [_mapView addAnnotation:annotation];
        //2
        MKCoordinateRegion viewRegion  = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        //3
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
        //4
        [_mapView setRegion:adjustedRegion animated:YES];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.detailDescriptionLabel = nil;
    self.detailDescriptionTextView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 37.2630556, longitude = -115.7930198;//51Area
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"geoCodeUsingAddress result:%@",result);
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        //
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    //
    NSLog(@"geoCodeUsingAddress coordinate2D:%f,%f",latitude,longitude);
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"SightingLocation";
    if ([annotation isKindOfClass:[SightingLocation class]]) {
        MKAnnotationView *annotationView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotation == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
//        annotationView.image = [UIImage imageNamed:@"TODO"];//FIXME,custom image
        return annotationView;
    }
    return nil;
}

@end
