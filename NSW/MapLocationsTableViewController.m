//
//  MapLocationsTableViewController.m
//  NSW
//
//  Created by Stephen Grinich on 7/27/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MapLocationsTableViewController.h"
#import "LocationTableViewCell.h"
#import "MapLocation.h"
#import <GoogleMaps/GoogleMaps.h>


@interface MapLocationsTableViewController ()

@end

@implementation MapLocationsTableViewController

@synthesize locationsList = _locationsList;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    
    [_locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _locationsList = [[NSMutableArray alloc] init];
    
    // User Location
    GMSMarker *myLocationMarker = [[GMSMarker alloc] init];
    myLocationMarker.position = CLLocationCoordinate2DMake(_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude);
    myLocationMarker.title = @"You are here";
    MapLocation *myLocation = [[MapLocation alloc]initWithLocation:@"Where am I?" Coordinates:myLocationMarker];
    [_locationsList addObject:myLocation];
    
    // Allen House
    GMSMarker *allenMarker = [[GMSMarker alloc] init];
    allenMarker.position = CLLocationCoordinate2DMake(44.460106, -93.158276);
    allenMarker.title = @"Allen House";
    MapLocation *allen = [[MapLocation alloc]initWithLocation:@"Allen House" Coordinates:allenMarker];
    [_locationsList addObject:allen];
    
    // Benton House
    GMSMarker *bentonMarker = [[GMSMarker alloc] init];
    bentonMarker.position = CLLocationCoordinate2DMake(44.458730, -93.154315);
    bentonMarker.title = @"Benton House";
    MapLocation *benton = [[MapLocation alloc]initWithLocation:@"Benton House" Coordinates:bentonMarker];
    [_locationsList addObject:benton];
    
    // Berg House
    GMSMarker *bergMarker = [[GMSMarker alloc] init];
    bergMarker.position = CLLocationCoordinate2DMake(44.458782, -93.157437);
    bergMarker.title = @"Berg House";
    MapLocation *berg = [[MapLocation alloc]initWithLocation:@"Berg House" Coordinates:bergMarker];
    [_locationsList addObject:berg];
    
    // Brooks House
    GMSMarker *brooksMarker = [[GMSMarker alloc] init];
    brooksMarker.position = CLLocationCoordinate2DMake(44.459607, -93.157974);
    brooksMarker.title = @"Brooks House";
    MapLocation *brooks = [[MapLocation alloc]initWithLocation:@"Brooks House" Coordinates:brooksMarker];
    [_locationsList addObject:brooks];
    
    // Burton Hall
    GMSMarker *burtonMarker = [[GMSMarker alloc] init];
    burtonMarker.position = CLLocationCoordinate2DMake(44.460560, -93.156772);
    burtonMarker.title = @"Burton Hall";
    MapLocation *burton = [[MapLocation alloc]initWithLocation:@"Burton Hall" Coordinates:burtonMarker];
    [_locationsList addObject:burton];
    
    // Cassat Hall
    GMSMarker *cassatMarker = [[GMSMarker alloc] init];
    cassatMarker.position = CLLocationCoordinate2DMake(44.460041, -93.151038);
    cassatMarker.title = @"Burton Hall";
    MapLocation *cassat = [[MapLocation alloc]initWithLocation:@"Cassat Hall" Coordinates:cassatMarker];
    [_locationsList addObject:cassat];
    
    // Chaney House
    GMSMarker *chaneyMarker = [[GMSMarker alloc] init];
    chaneyMarker.position = CLLocationCoordinate2DMake(44.458786, -93.150567);
    chaneyMarker.title = @"Chaney House";
    MapLocation *chaney = [[MapLocation alloc]initWithLocation:@"Chaney House" Coordinates:chaneyMarker];
    [_locationsList addObject:chaney];
    
    // Clader House
    GMSMarker *claderMarker = [[GMSMarker alloc] init];
    claderMarker.position = CLLocationCoordinate2DMake(44.458692, -93.157743);
    claderMarker.title = @"Clader House";
    MapLocation *clader = [[MapLocation alloc]initWithLocation:@"Clader House" Coordinates:claderMarker];
    [_locationsList addObject:clader];
    
    // Collier House
    GMSMarker *collierMarker = [[GMSMarker alloc] init];
    collierMarker.position = CLLocationCoordinate2DMake(44.459281, -93.158174);
    collierMarker.title = @"Collier House";
    MapLocation *collier = [[MapLocation alloc]initWithLocation:@"Collier House" Coordinates:collierMarker];
    [_locationsList addObject:collier];
    
    // Colwell House
    GMSMarker *colwellMarker = [[GMSMarker alloc] init];
    colwellMarker.position = CLLocationCoordinate2DMake(44.458798, -93.158599);
    colwellMarker.title = @"Colwell House";
    MapLocation *colwell = [[MapLocation alloc]initWithLocation:@"Colwell House" Coordinates:colwellMarker];
    [_locationsList addObject:colwell];
    
    // Dacie Moses House
    GMSMarker *dacieMarker = [[GMSMarker alloc] init];
    dacieMarker.position = CLLocationCoordinate2DMake(44.459047, -93.157389);
    dacieMarker.title = @"Dacie Moses House";
    MapLocation *dacie = [[MapLocation alloc]initWithLocation:@"Dacie Moses House" Coordinates:dacieMarker];
    [_locationsList addObject:dacie];
    
    // Davis Hall
    GMSMarker *davisMarker = [[GMSMarker alloc] init];
    davisMarker.position = CLLocationCoordinate2DMake(44.460083, -93.156764);
    davisMarker.title = @"Burton Hall";
    MapLocation *davis = [[MapLocation alloc]initWithLocation:@"Davis Hall" Coordinates:davisMarker];
    [_locationsList addObject:davis];
    
    // Dixon House
    GMSMarker *dixonMarker = [[GMSMarker alloc] init];
    dixonMarker.position = CLLocationCoordinate2DMake(44.459147, -93.158261);
    dixonMarker.title = @"Dixon House";
    MapLocation *dixon = [[MapLocation alloc]initWithLocation:@"Dixon House" Coordinates:dixonMarker];
    [_locationsList addObject:dixon];
    
    // Douglas House
    GMSMarker *douglasMarker = [[GMSMarker alloc] init];
    douglasMarker.position = CLLocationCoordinate2DMake(44.457572,  -93.155313);
    douglasMarker.title = @"Douglas House";
    MapLocation *douglas = [[MapLocation alloc]initWithLocation:@"Douglas House" Coordinates:douglasMarker];
    [_locationsList addObject:douglas];
    
    // Dow House
    GMSMarker *dowMarker = [[GMSMarker alloc] init];
    dowMarker.position = CLLocationCoordinate2DMake(44.459012, -93.158340);
    dowMarker.title = @"Dow House";
    MapLocation *dow = [[MapLocation alloc]initWithLocation:@"Dow House" Coordinates:dowMarker];
    [_locationsList addObject:dow];
    
    // Eugster House
    GMSMarker *eugsterMarker = [[GMSMarker alloc] init];
    eugsterMarker.position = CLLocationCoordinate2DMake(44.459982, -93.157742);
    eugsterMarker.title = @"Eugster House";
    MapLocation *eugster = [[MapLocation alloc]initWithLocation:@"Eugster House" Coordinates:eugsterMarker];
    [_locationsList addObject:eugster];
    
    // Evans Hall
    GMSMarker *evansMarker = [[GMSMarker alloc] init];
    evansMarker.position = CLLocationCoordinate2DMake(44.460367, -93.149829);
    evansMarker.title = @"Evans Hall";
    MapLocation *evans = [[MapLocation alloc]initWithLocation:@"Evans Hall" Coordinates:evansMarker];
    [_locationsList addObject:evans];
    
    // Faculty Club
    GMSMarker *facultyMarker = [[GMSMarker alloc] init];
    facultyMarker.position = CLLocationCoordinate2DMake(44.458725, -93.149517);
    facultyMarker.title = @"Faculty Club";
    MapLocation *faculty = [[MapLocation alloc]initWithLocation:@"Faculty Club" Coordinates:facultyMarker];
    [_locationsList addObject:faculty];
    
    // Farm House
    GMSMarker *farmMarker = [[GMSMarker alloc] init];
    farmMarker.position = CLLocationCoordinate2DMake(44.466051, -93.149448);
    farmMarker.title = @"Farm House";
    MapLocation *farm = [[MapLocation alloc]initWithLocation:@"Farm House" Coordinates:farmMarker];
    [_locationsList addObject:farm];
    
    // Geffert House
    GMSMarker *geffertMarker = [[GMSMarker alloc] init];
    geffertMarker.position = CLLocationCoordinate2DMake(44.458901, -93.158990);
    geffertMarker.title = @"Geffert House";
    MapLocation *geffert = [[MapLocation alloc]initWithLocation:@"Geffert House" Coordinates:geffertMarker];
    [_locationsList addObject:geffert];
    
    // Goodhue Hall
    GMSMarker *goodhueMarker = [[GMSMarker alloc] init];
    goodhueMarker.position = CLLocationCoordinate2DMake(44.462455, -93.149728);
    goodhueMarker.title = @"Goodhue Hall";
    MapLocation *goodhue = [[MapLocation alloc]initWithLocation:@"Goodhue Hall" Coordinates:goodhueMarker];
    [_locationsList addObject:goodhue];
    
    // Hall House
    GMSMarker *hallMarker = [[GMSMarker alloc] init];
    hallMarker.position = CLLocationCoordinate2DMake(44.459512, -93.157912);
    hallMarker.title = @"Hall House";
    MapLocation *hall = [[MapLocation alloc]initWithLocation:@"Hall House" Coordinates:hallMarker];
    [_locationsList addObject:hall];
    
    // Henrickson House
    GMSMarker *henricksonMarker = [[GMSMarker alloc] init];
    henricksonMarker.position = CLLocationCoordinate2DMake(44.458617, -93.158195);
    henricksonMarker.title = @"Henrickson House";
    MapLocation *henrickson = [[MapLocation alloc]initWithLocation:@"Henrickson House" Coordinates:henricksonMarker];
    [_locationsList addObject:henrickson];
    
    // Hill House
    GMSMarker *hillMarker = [[GMSMarker alloc] init];
    hillMarker.position = CLLocationCoordinate2DMake(44.458083, -93.155302);
    hillMarker.title = @"Hill House";
    MapLocation *hill = [[MapLocation alloc]initWithLocation:@"Hill House" Coordinates:hillMarker];
    [_locationsList addObject:hill];
    
    // Hunt Cottage
    GMSMarker *huntCottageMarker = [[GMSMarker alloc] init];
    huntCottageMarker.position = CLLocationCoordinate2DMake(44.459257, -93.157413);
    huntCottageMarker.title = @"Hunt Cottage";
    MapLocation *huntCottage = [[MapLocation alloc]initWithLocation:@"Hunt Cottage" Coordinates:huntCottageMarker];
    [_locationsList addObject:huntCottage];
    
    // Hunt House
    GMSMarker *huntHouseMarker = [[GMSMarker alloc] init];
    huntHouseMarker.position = CLLocationCoordinate2DMake(44.458623, -93.158451);
    huntHouseMarker.title = @"Hunt House";
    MapLocation *huntHouse = [[MapLocation alloc]initWithLocation:@"Hunt House" Coordinates:huntHouseMarker];
    [_locationsList addObject:huntHouse];
    
    // Huntington House
    GMSMarker *huntingtonMarker = [[GMSMarker alloc] init];
    huntingtonMarker.position = CLLocationCoordinate2DMake(44.458751, -93.155342);
    huntingtonMarker.title = @"Huntington House";
    MapLocation *huntington = [[MapLocation alloc]initWithLocation:@"Huntington House" Coordinates:huntingtonMarker];
    [_locationsList addObject:huntington];
    
    // James Hall
    GMSMarker *jamesMarker = [[GMSMarker alloc] init];
    jamesMarker.position = CLLocationCoordinate2DMake(44.460025, -93.151773);
    jamesMarker.title = @"James Hall";
    MapLocation *james = [[MapLocation alloc]initWithLocation:@"James Hall" Coordinates:jamesMarker];
    [_locationsList addObject:james];
    
    // Jewett House
    GMSMarker *jewettMarker = [[GMSMarker alloc] init];
    jewettMarker.position = CLLocationCoordinate2DMake(44.457677, -93.157513);
    jewettMarker.title = @"Jewett House";
    MapLocation *jewett = [[MapLocation alloc]initWithLocation:@"Jewett House" Coordinates:jewettMarker];
    [_locationsList addObject:jewett];
    
    // Musser Hall
    GMSMarker *musserMarker = [[GMSMarker alloc] init];
    musserMarker.position = CLLocationCoordinate2DMake(44.459934, -93.157050);
    musserMarker.title = @"Musser Hall";
    MapLocation *musser = [[MapLocation alloc]initWithLocation:@"Musser Hall" Coordinates:musserMarker];
    [_locationsList addObject:musser];
    
    // Myers Hall
    GMSMarker *myersMarker = [[GMSMarker alloc] init];
    myersMarker.position = CLLocationCoordinate2DMake(44.460721, -93.150870);
    myersMarker.title = @"Myers Hall";
    MapLocation *myers = [[MapLocation alloc]initWithLocation:@"Myers Hall" Coordinates:myersMarker];
    [_locationsList addObject:myers];
    
    // Nason House
    GMSMarker *nasonMarker = [[GMSMarker alloc] init];
    nasonMarker.position = CLLocationCoordinate2DMake(44.459740, -93.157676);
    nasonMarker.title = @"Nason House";
    MapLocation *nason = [[MapLocation alloc]initWithLocation:@"Nason House" Coordinates:nasonMarker];
    [_locationsList addObject:nason];
    
    // Nourse Hall
    GMSMarker *nourseMarker = [[GMSMarker alloc] init];
    nourseMarker.position = CLLocationCoordinate2DMake(44.460491, -93.152017);
    nourseMarker.title = @"Nourse Hall";
    MapLocation *nourse = [[MapLocation alloc]initWithLocation:@"Nourse Hall" Coordinates:nourseMarker];
    [_locationsList addObject:nourse];
    
    // Owens House
    GMSMarker *owensMarker = [[GMSMarker alloc] init];
    owensMarker.position = CLLocationCoordinate2DMake(44.459443, -93.158074);
    owensMarker.title = @"Owens House";
    MapLocation *owens = [[MapLocation alloc]initWithLocation:@"Owens House" Coordinates:owensMarker];
    [_locationsList addObject:owens];
    
    // Page House
    GMSMarker *pageMarker = [[GMSMarker alloc] init];
    pageMarker.position = CLLocationCoordinate2DMake(44.457587, -93.155817);
    pageMarker.title = @"Page House";
    MapLocation *page = [[MapLocation alloc]initWithLocation:@"Page House" Coordinates:pageMarker];
    [_locationsList addObject:page];
    
    // Parish House
    GMSMarker *parishMarker = [[GMSMarker alloc] init];
    parishMarker.position = CLLocationCoordinate2DMake(44.457589, -93.154857);
    parishMarker.title = @"Parish House";
    MapLocation *parish = [[MapLocation alloc]initWithLocation:@"Parish House" Coordinates:parishMarker];
    [_locationsList addObject:parish];
    
    // Parr House
    GMSMarker *parrMarker = [[GMSMarker alloc] init];
    parrMarker.position = CLLocationCoordinate2DMake(44.466390, -93.149292);
    parrMarker.title = @"Parr House";
    MapLocation *parr = [[MapLocation alloc]initWithLocation:@"Parish House" Coordinates:parrMarker];
    [_locationsList addObject:parr];
    
    // Prentice House
    GMSMarker *prenticeMarker = [[GMSMarker alloc] init];
    prenticeMarker.position = CLLocationCoordinate2DMake(44.459940, -93.158371);
    prenticeMarker.title = @"Prentice House";
    MapLocation *prentice = [[MapLocation alloc]initWithLocation:@"Prentice House" Coordinates:prenticeMarker];
    [_locationsList addObject:prentice];
    
    // Rice House
    GMSMarker *riceMarker = [[GMSMarker alloc] init];
    riceMarker.position = CLLocationCoordinate2DMake(44.457976, -93.155882);
    riceMarker.title = @"Rice House";
    MapLocation *rice = [[MapLocation alloc]initWithLocation:@"Rice House" Coordinates:riceMarker];
    [_locationsList addObject:rice];
    
    // Scott House
    GMSMarker *scottMarker = [[GMSMarker alloc] init];
    scottMarker.position = CLLocationCoordinate2DMake(44.459825, -93.157787);
    scottMarker.title = @"Scott House";
    MapLocation *scott = [[MapLocation alloc]initWithLocation:@"Scott House" Coordinates:scottMarker];
    [_locationsList addObject:scott];
    
    // Severance Hall
    GMSMarker *severanceMarker = [[GMSMarker alloc] init];
    severanceMarker.position = CLLocationCoordinate2DMake(44.460972, -93.156760);
    severanceMarker .title = @"Nourse Hall";
    MapLocation *severance = [[MapLocation alloc]initWithLocation:@"Severance Hall" Coordinates:severanceMarker];
    [_locationsList addObject:severance];
    
    // Stimson House
    GMSMarker *stimsonMarker = [[GMSMarker alloc] init];
    stimsonMarker.position = CLLocationCoordinate2DMake(44.459488, -93.156788);
    stimsonMarker.title = @"Stimson House";
    MapLocation *stimson = [[MapLocation alloc]initWithLocation:@"Stimson House" Coordinates:stimsonMarker];
    [_locationsList addObject:stimson];
    
    // Watson Hall
    GMSMarker *watsonMarker = [[GMSMarker alloc] init];
    watsonMarker.position = CLLocationCoordinate2DMake(44.459390, -93.150524);
    watsonMarker .title = @"Watson Hall";
    MapLocation *watson = [[MapLocation alloc]initWithLocation:@"Watson Hall" Coordinates:watsonMarker];
    [_locationsList addObject:watson];
    
    // Williams House
    GMSMarker *williamsMarker = [[GMSMarker alloc] init];
    williamsMarker.position = CLLocationCoordinate2DMake(44.459111, -93.156947);
    williamsMarker .title = @"Williams House";
    MapLocation *williams = [[MapLocation alloc]initWithLocation:@"Williams House" Coordinates:williamsMarker];
    [_locationsList addObject:williams];
    
    // Wilson House
    GMSMarker *wilsonMarker = [[GMSMarker alloc] init];
    wilsonMarker.position = CLLocationCoordinate2DMake(44.460252, -93.158135);
    wilsonMarker.title = @"Wilson House";
    MapLocation *wilson = [[MapLocation alloc]initWithLocation:@"Wilson House" Coordinates:wilsonMarker];
    [_locationsList addObject:wilson];

    
    
    
    return [_locationsList count];
}


- (LocationTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.locationLabel.text = [[_locationsList objectAtIndex:indexPath.row] maplocation];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MapLocation *selectedLocation = [_locationsList objectAtIndex:[indexPath row]];
    
   
    [self.delegate addItemViewController:self didFinishEnteringItem:selectedLocation];
    
    [self dismissModalViewControllerAnimated:YES];
}
    
    
    



@end
