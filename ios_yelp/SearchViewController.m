//
//  SearchViewController.m
//  ios_yelp
//
//  Created by Stanley Ng on 6/20/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "SearchViewController.h"
#import "FiltersViewController.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface SearchViewController ()

@property (nonatomic, strong) YelpClient *client;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                               consumerSecret:kYelpConsumerSecret
                                                  accessToken:kYelpToken
                                                 accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai"
                            success:^(AFHTTPRequestOperation *operation, id response) {
                                NSLog(@"response: %@", response);
                            }
                            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                NSLog(@"error: %@", [error description]);
                            }];
        
        [self customizeLeftNavBarButtons];
        self.title = @"Search";
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
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"   Filter   " forState:UIControlStateNormal];
    //button.frame = CGRectMake(0, 0, 50, 50);
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setCornerRadius:3.0f];
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    [button sizeToFit];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    */
    
    UIBarButtonItem *barButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                         style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(handleFilterButton)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)handleFilterButton
{
    NSLog(@"handleFilterButton");
    
    UIViewController *vc = [[FiltersViewController alloc] init];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
