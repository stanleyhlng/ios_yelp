//
//  FiltersViewController.h
//  ios_yelp
//
//  Created by Stanley Ng on 6/21/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)searchButtonClicked:(FiltersViewController *)controller message:(NSString *)message;

@end

@interface FiltersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;

@end
