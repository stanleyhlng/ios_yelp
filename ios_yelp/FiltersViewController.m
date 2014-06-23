//
//  FiltersViewController.m
//  ios_yelp
//
//  Created by Stanley Ng on 6/21/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filtersTableView;
@property (nonatomic, assign) NSInteger collapsedSectionIndex;
@property (nonatomic, strong) NSArray *filters;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self customizeLeftNavBarButtons];
        [self customizeRightNavBarButtons];
        
        [self initFilters];
        
        self.title = @"Filters";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self;
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

- (void)initFilters
{
    NSLog(@"initFilters");
    
    self.filters = @[
        @{
            @"name": @"Most Popular"
        },
        @{
            @"name": @"Distance"
        },
        @{
            @"name": @"Sort by"
        },
        @{
            @"name": @"Categories"
        }
    ];
    
    NSLog(@"filters: %@", self.filters);
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int previousCollapsedIndex = self.collapsedSectionIndex;

    self.collapsedSectionIndex = indexPath.section;

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:previousCollapsedIndex];
    [indexSet addIndex:self.collapsedSectionIndex];
    
    [self.filtersTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"view for header in section %d", section);
    
    NSDictionary *filter = [self.filters objectAtIndex:section];
    NSString *title = filter[@"name"];
    NSLog(@"name: %@", title);
    
    UIFont *customFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    CGSize labelSize = [title sizeWithAttributes:
  @{
    @"NSFontAttributeName":customFont
    }];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    label.text = title;
    label.font = customFont;
    label.numberOfLines = 1;
    label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 10.0f/12.0f;;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    [label sizeToFit];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    //headerView.backgroundColor = [UIColor colorWithRed:(arc4random() % 256 / 255.0f) green:(arc4random() % 256 / 255.0f) blue:(arc4random() % 256 / 255.0f) alpha:1.0f];
    //return headerView;
    
    [headerView addSubview:label];
    return headerView;
}
 */


# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.filters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.collapsedSectionIndex == section) {
        return 1;
    }
    else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    NSLog(@"section: %d, row %d", indexPath.section, indexPath.row);
    cell.textLabel.text = [NSString stringWithFormat:@"section: %d, row %d", indexPath.section, indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.filters objectAtIndex:section][@"name"];
}

@end
