//
//  ViewController.m
//  SharingDemo
//
//  Created by TheAppGuruz-New-6 on 11/04/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShareImageClicked:(id)sender
{
    
}

- (IBAction)btnShareURLClicked:(id)sender
{
}

- (IBAction)btnShareTextClicked:(id)sender
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShareViewController *obj=[segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"shareImage"])
    {
        [obj setBtnid:@"1"];
    }
    if ([[segue identifier] isEqualToString:@"shareURL"])
    {
        [obj setBtnid:@"2"];
    }
    if ([[segue identifier] isEqualToString:@"shareText"])
    {
        [obj setBtnid:@"3"];
    }
}

@end
