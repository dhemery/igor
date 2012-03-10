//
//  CombinatorMatcher.m
//  igor
//
//  Created by Dale Emery on 3/8/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "DescendantCombinatorMatcher.h"

@implementation DescendantCombinatorMatcher

@synthesize ancestorMatcher, descendantMatcher;

- (NSMutableSet*)ancestorsOfView:(UIView *)view {
    NSMutableSet* ancestors = [NSMutableSet set];
    id ancestor = [view superview];
    while(ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return ancestors;
}

- (BOOL)ancestorMatcherMatchesAnAncestorOfView:(UIView *)view {
    for(id ancestor in [self ancestorsOfView:view]) {
        if([ancestorMatcher matchesView:ancestor]) {
            return true;
        }
    }
    return false;
}

- (BOOL)matchesView:(UIView *)view {
    return [descendantMatcher matchesView:view] && [self ancestorMatcherMatchesAnAncestorOfView:view];
}

+(id) forAncestorMatcher:(id<Matcher>) ancestorMatcher descendantMatcher:(id<Matcher>) descendantMatcher {
    return [[self alloc] initWithAncestorMatcher:ancestorMatcher descendantMatcher:descendantMatcher];
}

-(id) initWithAncestorMatcher:(id<Matcher>) anAncestorMatcher descendantMatcher:(id<Matcher>) aDescendantMatcher {
    if(self = [super init]) {
        self.ancestorMatcher = anAncestorMatcher;
        self.descendantMatcher = aDescendantMatcher;
    }
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"[DescendantCombinatorMatcher:[descendantMatcher:%@][ancestorMatcher:%@]]", descendantMatcher, ancestorMatcher];
}

@end
