//
//  MapViewController.m
//  CoreLocationAndMapKit
//
//  Created by Filipe Patrício on 11/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "CoolBar.h"
#import "CoolBarList.h"

#import <AVFoundation/AVFoundation.h>

@interface MapViewController ()<MKMapViewDelegate, UIActionSheetDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (copy, nonatomic) NSArray *baresArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

@property (nonatomic, strong) CLLocation *selectedLocation;

@property (strong, nonatomic) NSMutableArray *cameras;
@end

@implementation MapViewController

-(NSArray *)baresArray
{
    if(!_baresArray)
        _baresArray = [CoolBarList allCoolBarsFromPList];
    return _baresArray;
}

- (void)addBarPins {
    //Erase all annotations before insert
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView addAnnotations:self.baresArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.showsUserLocation = YES;
    
    [self addBarPins];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self actionCenterMap:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionChangeMapStyle:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Map Style"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Standard", @"Satellite", @"Hybrid", nil];
    
    [actionSheet showInView:self.view];
}
- (IBAction)actionCenterMap:(id)sender
{
    CLLocationCoordinate2D myCoord = self.mapView.userLocation.coordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myCoord, 1000, 1000);
    
    MKCoordinateRegion adjustRegion = [self.mapView regionThatFits:viewRegion];
    
    [self.mapView setRegion:adjustRegion animated:YES];
    
//    [self calculateRoute];
}

#pragma mark UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self.mapView setMapType:MKMapTypeStandard];
            break;
        case 1:
            [self.mapView setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [self.mapView setMapType:MKMapTypeHybrid];
            break;
            
        default:
            break;
    }
}

#pragma mark MKMapKitDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000.0f, 1000.0f);
//    
//    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:region];
//    [self.mapView setRegion:adjustedRegion animated:YES];
}


#pragma mark Custom Annotations

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{

    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotationView"];
    
    if(!annotationView)
    {
        annotationView = [[MKAnnotationView alloc ]initWithAnnotation:annotation reuseIdentifier:@"myAnnotationView"];
    }
    
    if(annotation == mapView.userLocation)
    {
        annotationView.image = [UIImage imageNamed:@"map-marker"];
    }
    else if([annotation isKindOfClass:[CoolBar class]])
    {
        CoolBar *bar = (CoolBar*)annotation;
        switch (bar.type) {
            case classic_bar:
                annotationView.image = [UIImage imageNamed:@"map-marker"];
                break;
            case disco:
                annotationView.image = [UIImage imageNamed:@"medical"];
                break;
            case piano_bar:
                annotationView.image = [UIImage imageNamed:@"chat"];
                break;
            case tapas_bar:
                annotationView.image = [UIImage imageNamed:@"skull"];
                break;
                
            default:
                break;
        }
    }
    
    [annotationView setCanShowCallout:YES];
    
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (MKAnnotationView *annView in views)
    {
        CGRect endFrame = annView.frame;
        annView.frame = CGRectOffset(endFrame, 0, -500);
        
        [UIView animateWithDuration:2 animations:^{
            annView.frame = endFrame;
        }];
    }
}

-(void)localSearch:(NSString *)query{
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    
    request.naturalLanguageQuery = query;
    request.region = self.mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if (!error) {
            
            NSLog(@"Response!");
            
            for (MKMapItem *poi in response.mapItems) {
                
                NSLog(@"%@", poi);
                CoolBar *bar = [[CoolBar alloc] init];
                bar.name = poi.name;
                bar.coordinate = poi.placemark.coordinate;
                
                [self.mapView addAnnotation:bar];
                
            }
            
        }
        
    }];
    
    
}

-(void)geoLocateAddress:(NSString *)address{
    
    NSMutableDictionary *placeDictionary = [[NSMutableDictionary alloc]init];
    
    NSArray *keys = @[@"Street", @"City"];
    
    NSArray *addressComponents = [address componentsSeparatedByString:@","];
    
    if (addressComponents.count == 2) {
        [addressComponents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [placeDictionary setObject:obj forKey:keys[idx]];
            
            
        }];
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder geocodeAddressDictionary:placeDictionary completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if ([placemarks count]) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            [self centerMap: self.mapView inCoordinate:coordinate];
            
            
            
        }
        
    }];
    
}

-(void)centerMap:(MKMapView*)map inCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 10, 10);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    
    [map setRegion:adjustedRegion animated:YES];
}

- (IBAction)actionTravel:(id)sender
{
    self.cameras = [[NSMutableArray alloc] init];
    for(CoolBar *bar in self.baresArray)
    {
        [self addCameraUsingBar:bar];
    }
    
    [self goToNextCamera];
}

-(void)addCameraUsingBar:(CoolBar *)bar
{
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:bar.coordinate fromEyeCoordinate:bar.coordinate eyeAltitude:100];
    camera.pitch = 60;
    
    [self.cameras addObject:camera];
}

-(void)goToNextCamera
{
    if(self.cameras.count == 0)
    {
        [self actionCenterMap:nil];
        return;
    }
    
    MKMapCamera *nextCamera = [self.cameras firstObject];
    [self.cameras removeObjectAtIndex:0];
    
    [UIView animateWithDuration:2.5
                          delay:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.mapView setCamera:nextCamera];
                     }completion:^(BOOL finished) {
                         [self goToNextCamera];
                     }];
}


#pragma mark Reverse geocode

- (IBAction)mapTap:(id)sender {
    
    
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    CGPoint tapPoint = [tap locationInView:self.mapView];
    
    CLLocationCoordinate2D coord = [self.mapView convertPoint:tapPoint
                                     toCoordinateFromView:self.mapView];
    
    
    self.selectedLocation = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [self reverseGeocodeLocation];
    
}

-(void)reverseGeocodeLocation {
    
    NSLog(@"Coord %f",self.selectedLocation.coordinate.latitude);
    NSLog(@"Coord %f",self.selectedLocation.coordinate.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.selectedLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(placemarks.count){
            NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
            NSDictionary *surfaceDictionary = [dictionary valueForKey:@"Street"];
            
            NSMutableString *reverseGeocodedAddress;
            //Check if land
            if (surfaceDictionary){
                
                reverseGeocodedAddress = [NSMutableString stringWithFormat:@"%@", [dictionary valueForKey:@"Street"]];
                
                [reverseGeocodedAddress appendString:[dictionary valueForKey:@"City"]];
                [reverseGeocodedAddress appendString:[dictionary valueForKey:@"State"]];
                [reverseGeocodedAddress appendString:[dictionary valueForKey:@"ZIP"]];
                
            } else {
                reverseGeocodedAddress = [NSMutableString stringWithFormat:@"%@", [dictionary valueForKey:@"Name"]];
                [reverseGeocodedAddress appendString:[dictionary valueForKey:@"Ocean"]];
                
            }
            
            
            self.searchBar.text = reverseGeocodedAddress;
            
            [self calculateRoute];
            
            
        }
    }];
    
}


#pragma mark Routes

-(void)calculateRoute {
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    request.transportType = MKDirectionsTransportTypeWalking;
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.selectedLocation.coordinate  addressDictionary:nil] ;
    
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    
    request.destination = destinationMapItem;
    
    request.requestsAlternateRoutes = YES;
    
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         
         if (error) {
             // Handle Error
         } else {
             
             
             [self showRoute:response];
         }
         
     }];
}


-(void)showRoute:(MKDirectionsResponse *)response
{
    [self.mapView removeOverlays:self.mapView.overlays];
    for (MKRoute *route in response.routes){
        
        [self.mapView
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps){
            
            NSLog(@"%@", step.instructions);
            
            AVSpeechUtterance *utterance = [AVSpeechUtterance
                                            speechUtteranceWithString:step.instructions];
            
            AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
            [synth speakUtterance:utterance];
            
        }
        
    }
    
    
    
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
    
    
}

#pragma mark UISearchBar

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    if([text isEqualToString:@"\n"])
    {
        [searchBar resignFirstResponder];
        
        if(self.modeSwitch.isOn)
            [self localSearch:self.searchBar.text];
        else
            [self geoLocateAddress:self.searchBar.text];
    }

    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
