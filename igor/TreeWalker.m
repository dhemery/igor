//
//  TreeWalker.m
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "TreeWalker.h"
#import "Matcher.h"

@implementation TreeWalker

-(void) findViewsThatMatch:(id<Matcher>)matcher fromRoot:(UIView *)root intoSet:(NSMutableSet*)matchingViews {
    if ([matcher matchesView:root]) {
        [matchingViews addObject:root];
    }
    for(id subview in [root subviews]) {
        [self findViewsThatMatch:matcher fromRoot:subview intoSet:matchingViews];
    }
}

@end
