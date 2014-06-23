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
#import "UIImageView+AFNetworking.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GSProgressHUD.h"

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

    [self.businessesTableView setRowHeight:110.0f];
    
    [self doFetch:@"Thai"];
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
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}

- (void)doFetch:(NSString *)term
{
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    
    [GSProgressHUD show];

    [self.client searchWithTerm:term
                        success:^(AFHTTPRequestOperation *operation, id response) {
                            //NSLog(@"response: %@", response);
                            
                            self.businesses = response[@"businesses"];

                            [self.businessesTableView reloadData];
                            
                            [GSProgressHUD dismiss];
                        }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"error: %@", [error description]);

                            [GSProgressHUD dismiss];
                        }];
}

- (void)handleFilterButton
{
    NSLog(@"handleFilterButton");
    
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
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
    
    NSDictionary *business = self.businesses[indexPath.row];
    NSLog(@"business: %@", business);
    
    // Photo Box
    [cell.photoBoxImageView setAlpha:0.0f];
    [cell.photoBoxImageView setImageWithURL:[NSURL URLWithString:business[@"image_url"]]
                           placeholderImage:[UIImage imageNamed:@"photo-box-placeholder"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                      // Fade in image
                                      [UIView beginAnimations:@"fade in" context:nil];
                                      [UIView setAnimationDuration:1.0];
                                      [cell.photoBoxImageView setAlpha:1.0f];
                                      [UIView commitAnimations];
                                  }
                usingActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];

    // Name
    NSString *name = [NSString stringWithFormat:@"%d. %@", indexPath.row + 1, business[@"name"]];
    cell.nameLabel.numberOfLines = 0;
    cell.nameLabel.text = name;

    // Rating
    [cell.ratingImageView setImageWithURL:[NSURL URLWithString:business[@"rating_img_url"]]
                           placeholderImage:nil
                                  completed:nil];
    
    // Review Count
    NSString *count = [NSString stringWithFormat:@"%@ Reviews", business[@"review_count"]];
    cell.reviewCountLabel.text = count;
    
    // Address
    NSArray *addressList = business[@"location"][@"address"];
    addressList = [addressList arrayByAddingObjectsFromArray:business[@"location"][@"neighborhoods"]];
    NSString *address = [addressList componentsJoinedByString:@", "];
    cell.addressLabel.text = address;
    
    // Categories
    NSMutableArray *categoryList = [[NSMutableArray alloc] init];
    for (id object in business[@"categories"]) {
        [categoryList addObject:object[0]];
    }
    NSString *category = [categoryList componentsJoinedByString:@", "];
    cell.categoriesLabel.text = category;
    
    return cell;
}

# pragma mark - UISearchBar Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked %@", searchBar.text);
    
    [searchBar resignFirstResponder];

    [self doFetch:searchBar.text];
}

# pragma mark - FiltersViewController Methods

- (void)searchButtonClicked:(FiltersViewController *)controller message:(NSString *)message
{
    NSLog(@"searchButtonClicked %@", message);
}

@end
