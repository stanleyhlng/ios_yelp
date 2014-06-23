//
//  FiltersViewController.m
//  ios_yelp
//
//  Created by Stanley Ng on 6/21/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "FiltersViewController.h"
#import "Yelp.h"

@interface FiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filtersTableView;
//@property (nonatomic, assign) NSInteger collapsedSectionIndex;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self customizeLeftNavBarButtons];
        [self customizeRightNavBarButtons];
        
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

- (void)handleFilterForMostPopular:(id)sender
{
    NSLog(@"handle toggle deal, tag: %d", ((UISwitch *)sender).tag);
    
    NSDictionary *filter = [Yelp instance].filters[0];
    NSMutableDictionary *option = filter[@"options"][(int)((UISwitch *)sender).tag];
    if ([option[@"is_selected"] boolValue] == YES) {
        [option setValue:[NSNumber numberWithBool:NO] forKey:@"is_selected"];
    }
    else {
        [option setValue:[NSNumber numberWithBool:YES] forKey:@"is_selected"];
    }
    NSLog(@"option: %@", option);
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
/*
    int previousCollapsedIndex = self.collapsedSectionIndex;

    self.collapsedSectionIndex = indexPath.section;

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:previousCollapsedIndex];
    [indexSet addIndex:self.collapsedSectionIndex];
    
    [self.filtersTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
*/
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [Yelp instance].filters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)[[Yelp instance].filters objectAtIndex:section][@"options"]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    NSLog(@"section: %d, row %d", indexPath.section, indexPath.row);
    cell.textLabel.text = [NSString stringWithFormat:@"section: %d, row %d", indexPath.section, indexPath.row];
    
    NSDictionary *filter = [Yelp instance].filters[indexPath.section];
    NSDictionary *row = filter[@"options"][indexPath.row];
    
    if ([filter[@"name"] isEqualToString:@"Most Popular"]) {
        // MOST POPULAR
        cell.textLabel.text = row[@"name"];
        
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = switchView;
        [switchView setTag:indexPath.row];
        [switchView setOn:[row[@"is_selected"] boolValue] animated:NO];
        [switchView addTarget:self action:@selector(handleFilterForMostPopular:) forControlEvents:UIControlEventValueChanged];
    }
    else if ([filter[@"name"] isEqualToString:@"Distance"]) {
        // DISTANCE
    }
    else if ([filter[@"name"] isEqualToString:@"Sort by"]) {
        // SORT BY
    }
    else if ([filter[@"name"] isEqualToString:@"Categories"]) {
        // CATEGORIES
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[Yelp instance].filters objectAtIndex:section][@"name"];
}

@end
