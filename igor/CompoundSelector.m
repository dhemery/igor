//
//  CompoundSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "CompoundSelector.h"

@implementation CompoundSelector
@synthesize simpleSelectors;

-(CompoundSelector*) init {
    if(self = [super init]) {
        simpleSelectors = [NSMutableArray new];
    }
    return self;
}

-(void) addSelector:(id<Selector>)selector {
    [self.simpleSelectors addObject:selector];
}
  
-(BOOL) matchesView:(UIView *)view {
    return NO;
}

@end
