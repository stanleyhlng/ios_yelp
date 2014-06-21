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
#import "BusinessTableViewCell.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *businessesTableView;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self customizeLeftNavBarButtons];
        [self customizeNavBarTitleView];
        self.title = @"Search";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure TableView
    self.businessesTableView.delegate = self;
    self.businessesTableView.dataSource = self;
    
    [self.businessesTableView registerNib:[UINib nibWithNibName:@"BusinessTableViewCell"
                                                         bundle:nil]
                   forCellReuseIdentifier:@"BusinessTableViewCell"];
    [self.businessesTableView setRowHeight:80.0f];
    
    [self doFetch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeLeftNavBarButtons
{
    UIBarButtonItem *barButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                         style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(handleFilterButton)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)customizeNavBarTitleView
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];    
    self.navigationItem.titleView = searchBar;
}

- (void)doFetch
{
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Thai"
                        success:^(AFHTTPRequestOperation *operation, id response) {
                            //NSLog(@"response: %@", response);
                            
                            self.businesses = response[@"businesses"];

                            [self.businessesTableView reloadData];
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"error: %@", [error description]);
                        }];
}

- (void)handleFilterButton
{
    NSLog(@"handleFilterButton");
    
    UIViewController *vc = [[FiltersViewController alloc] init];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

# pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}

# pragma mark - TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for row at index path: %d", indexPath.row);
    
    static NSString *cellIdentifier = @"BusinessTableViewCell";
    BusinessTableViewCell *cell = [self.businessesTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    NSDictionary *business = self.businesses[indexPath.row];
    
    // name
    NSString *name = [NSString stringWithFormat:@"%d. %@", indexPath.row + 1, business[@"name"]];
    cell.nameLabel.text = name;
    
    return cell;
}

@end
