//
//  Yelp.h
//  ios_yelp
//
//  Created by Stanley Ng on 6/22/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Yelp : NSObject

@property (nonatomic, strong) NSArray *filters;

+ (instancetype)instance;

@end
