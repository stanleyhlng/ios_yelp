//
//  SearchViewController.h
//  ios_yelp
//
//  Created by Stanley Ng on 6/20/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersViewController.h"

@interface SearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate>

@end
