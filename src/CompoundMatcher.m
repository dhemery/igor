//
//  CompoundSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "CompoundMatcher.h"

@implementation CompoundMatcher

@synthesize simpleMatchers;

-(CompoundMatcher*) init {
    if(self = [super init]) {
        simpleMatchers = [NSMutableArray new];
    }
    return self;
}

-(void) addMatcher:(id<Matcher>)matcher {
    [self.simpleMatchers addObject:matcher];
}
  
-(BOOL) matchesView:(UIView *)view {
    for(id<Matcher> matcher in self.simpleMatchers) {
        if(![matcher matchesView:view]) return NO;
    }
    return YES;
}

@end
