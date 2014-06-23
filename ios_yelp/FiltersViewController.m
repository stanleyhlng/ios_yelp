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
//@property (nonatomic, assign) NSInteger collapsedSectionIndex;
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
            @"name": @"Most Popular",
            @"options":
                @[
                    @{@"name": @"Offering a Deal", @"is_selected": [NSNumber numberWithBool:NO]}
                ]
        },
        @{
            @"name": @"Distance",
            @"options":
                @[
                    @{@"name": @"Auto",      @"value": [NSNumber numberWithFloat:40000]},
                    @{@"name": @"0.3 miles", @"value": [NSNumber numberWithFloat:482.803]},
                    @{@"name": @"1 mile",    @"value": [NSNumber numberWithFloat:1609.34]},
                    @{@"name": @"5 miles",   @"value": [NSNumber numberWithFloat:8046.72]},
                    @{@"name": @"20 miles",  @"value": [NSNumber numberWithFloat:32186.9]}
                ],
            @"selected": [NSNumber numberWithInt:0]
        },
        @{
            @"name": @"Sort by",
            @"options":
                @[
                    @{@"name": @"Best Match",    @"value": [NSNumber numberWithInt:0]},
                    @{@"name": @"Distance",      @"value": [NSNumber numberWithInt:1]},
                    @{@"name": @"Rating",        @"value": [NSNumber numberWithInt:2]}
                ],
            @"selected": [NSNumber numberWithInt:0]
        },
        @{
            @"name": @"Categories",
            @"options":
                @[
                    @{@"name": @"American (New)",           @"value": @"newamerican",       @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"American (Traditional)",   @"value": @"tradamerican",      @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Argentine",                @"value": @"argentine",         @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Asian Fusion",             @"value": @"asianfusion",       @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Australian",               @"value": @"australian",        @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Austrian",                 @"value": @"austrian",          @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Beer Garden",              @"value": @"beergarden",        @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Belgian",                  @"value": @"belgian",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Brazilian",                @"value": @"brazilian",         @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Breakfast & Brunch",       @"value": @"breakfast_brunch",  @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Buffets",                  @"value": @"buffets",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Burgers",                  @"value": @"burgers",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Burmese",                  @"value": @"burmese",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Cafes",                    @"value": @"cafes",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Cajun/Creole",             @"value": @"cajun",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Canadian",                 @"value": @"newcanadian",       @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Chinese",                  @"value": @"chinese",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Cantonese",                @"value": @"cantonese",         @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Dim Sum",                  @"value": @"dimsum",            @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Cuban",                    @"value": @"cuban",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Diners",                   @"value": @"diners",            @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Dumplings",                @"value": @"dumplings",         @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Ethiopian",                @"value": @"ethiopian",         @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Fast Food",                @"value": @"hotdogs",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"French",                   @"value": @"french",            @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"German",                   @"value": @"german",            @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Greek",                    @"value": @"greek",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Indian",                   @"value": @"indpak",            @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Indonesian",               @"value": @"indonesian",        @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Irish",                    @"value": @"irish",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Italian",                  @"value": @"italian",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Japanese",                 @"value": @"japanese",          @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Jewish",                   @"value": @"jewish",            @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Korean",                   @"value": @"korean",            @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Venezuelan",               @"value": @"venezuelan",        @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Malaysian",                @"value": @"malaysian",         @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Pizza",                    @"value": @"pizza",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Russian",                  @"value": @"russian",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Salad",                    @"value": @"salad",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Scandinavian",             @"value": @"scandinavian",      @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Seafood",                  @"value": @"seafood",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Turkish",                  @"value": @"turkish",           @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Vegan",                    @"value": @"vegan",             @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Vegetarian",               @"value": @"vegetarian",        @"is_selected": [NSNumber numberWithBool:NO]},
                    @{@"name": @"Vietnamese",               @"value": @"vietnamese",        @"is_selected": [NSNumber numberWithBool:NO]}
                ]
        }
    ];
    
    NSLog(@"filters: %@", self.filters);
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
    return self.filters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)[self.filters objectAtIndex:section][@"options"]).count;
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
