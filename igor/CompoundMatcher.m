//
//  CompoundSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassMatcher.h"
#import "CompoundMatcher.h"
#import "PredicateMatcher.h"

@implementation CompoundMatcher

@synthesize simpleMatchers;

-(NSString*) description {
    return [NSString stringWithFormat:@"[CompoundMatcher:%@]", simpleMatchers];
}

+(CompoundMatcher*) forClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(PredicateMatcher*)predicateMatcher {
    return [[self alloc] initForClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

-(CompoundMatcher*) initForClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(PredicateMatcher*)predicateMatcher {
    if(self = [super init]) {
        simpleMatchers = [NSArray arrayWithObjects:classMatcher, predicateMatcher, nil];
    }
    return self;
}

-(BOOL) matchesView:(UIView *)view {
    for(id<Matcher> matcher in self.simpleMatchers) {
        if(![matcher matchesView:view]) return NO;
    }
    return YES;
}

@end
