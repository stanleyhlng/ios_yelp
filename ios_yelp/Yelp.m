//
//  Yelp.m
//  ios_yelp
//
//  Created by Stanley Ng on 6/22/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "Yelp.h"

@implementation Yelp

+ (instancetype)instance
{
    static Yelp *yelp = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        yelp = [Yelp new];

        NSArray *filters = @[
         @{
             @"name": @"Most Popular",
             @"options":
                 @[
                     [@{@"name": @"Offering a Deal", @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy]
                     ]
             },
         [@{
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
             } mutableCopy],
         [@{
             @"name": @"Sort by",
             @"options":
                 @[
                     @{@"name": @"Best Match",    @"value": [NSNumber numberWithInt:0]},
                     @{@"name": @"Distance",      @"value": [NSNumber numberWithInt:1]},
                     @{@"name": @"Rating",        @"value": [NSNumber numberWithInt:2]}
                     ],
             @"selected": [NSNumber numberWithInt:0]
             } mutableCopy],
         @{
             @"name": @"Categories",
             @"options":
                 @[
                     [@{@"name": @"American (New)",           @"value": @"newamerican",       @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"American (Traditional)",   @"value": @"tradamerican",      @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Argentine",                @"value": @"argentine",         @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Asian Fusion",             @"value": @"asianfusion",       @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Australian",               @"value": @"australian",        @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Austrian",                 @"value": @"austrian",          @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Beer Garden",              @"value": @"beergarden",        @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Belgian",                  @"value": @"belgian",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Brazilian",                @"value": @"brazilian",         @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Breakfast & Brunch",       @"value": @"breakfast_brunch",  @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Buffets",                  @"value": @"buffets",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Burgers",                  @"value": @"burgers",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Burmese",                  @"value": @"burmese",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Cafes",                    @"value": @"cafes",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Cajun/Creole",             @"value": @"cajun",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Canadian",                 @"value": @"newcanadian",       @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Chinese",                  @"value": @"chinese",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Cantonese",                @"value": @"cantonese",         @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Dim Sum",                  @"value": @"dimsum",            @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Cuban",                    @"value": @"cuban",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Diners",                   @"value": @"diners",            @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Dumplings",                @"value": @"dumplings",         @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Ethiopian",                @"value": @"ethiopian",         @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Fast Food",                @"value": @"hotdogs",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"French",                   @"value": @"french",            @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"German",                   @"value": @"german",            @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Greek",                    @"value": @"greek",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Indian",                   @"value": @"indpak",            @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Indonesian",               @"value": @"indonesian",        @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Irish",                    @"value": @"irish",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Italian",                  @"value": @"italian",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Japanese",                 @"value": @"japanese",          @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Jewish",                   @"value": @"jewish",            @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Korean",                   @"value": @"korean",            @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Venezuelan",               @"value": @"venezuelan",        @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Malaysian",                @"value": @"malaysian",         @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Pizza",                    @"value": @"pizza",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Russian",                  @"value": @"russian",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Salad",                    @"value": @"salad",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Scandinavian",             @"value": @"scandinavian",      @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Seafood",                  @"value": @"seafood",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Turkish",                  @"value": @"turkish",           @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Vegan",                    @"value": @"vegan",             @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Vegetarian",               @"value": @"vegetarian",        @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy],
                     [@{@"name": @"Vietnamese",               @"value": @"vietnamese",        @"is_selected": [NSNumber numberWithBool:NO]} mutableCopy]
                     ]
             }
        ];
        
        yelp.filters = filters;
        
    });
    
    return yelp;
}

- (NSMutableDictionary *)getSearchParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    // http://www.yelp.com/developers/documentation/v2/search_api
    params[@"term"] = @"";
    params[@"limit"] = [NSNumber numberWithInt:20];
    params[@"offset"] = [NSNumber numberWithInt:0];
    params[@"sort"] = self.filters[2][@"options"][[self.filters[2][@"selected"] intValue]][@"value"];
    
    NSMutableArray *selectedCategories = [[NSMutableArray alloc] init];
    for (id object in self.filters[3][@"options"]) {
        if ([object[@"is_selected"] boolValue] == YES) {
            [selectedCategories addObject:object[@"value"]];
        }
    }
    params[@"category_filter"] = [selectedCategories componentsJoinedByString:@","];
    params[@"radius_filter"] = self.filters[1][@"options"][[self.filters[1][@"selected"] intValue]][@"value"];
    params[@"deals_filter"] = self.filters[0][@"options"][0][@"is_selected"];
    params[@"location"] = @"San Jose";
    params[@"cll"] = @"37.400428,-121.925681";
    
    return params;
}

@end
