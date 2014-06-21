//
//  FiltersViewController.m
//  ios_yelp
//
//  Created by Stanley Ng on 6/21/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self customizeLeftNavBarButtons];
        [self customizeRightNavBarButtons];
        
        self.title = @"Filters";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeLeftNavBarButtons
{
    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(handleCancelButton)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)customizeRightNavBarButtons
{
    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Search"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(handleSearchButton)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)handleCancelButton
{
    NSLog(@"handleCancelButton");
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)handleSearchButton
{
    NSLog(@"handleSearchButton");
}

@end
