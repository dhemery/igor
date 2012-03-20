//
//  SubjectTestMatcher.m
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "SubjectSubtreeMatcher.h"
#import "TreeWalker.h"

@implementation SubjectSubtreeMatcher

@synthesize subjectMatcher, subtreeMatcher;

-(NSString*) description {
    return [NSString stringWithFormat:@"[SubjectTestMatcher:[subject:%@][subtree:%@]]", subjectMatcher, subtreeMatcher];
}

-(SubjectSubtreeMatcher*) initWithSubjectMatcher:(id<Matcher>)theSubjectMatcher subtreeMatcher:(id<Matcher>)theSubtreeMatcher {
    if(self = [super init]) {
        subjectMatcher = theSubjectMatcher;
        subtreeMatcher = theSubtreeMatcher;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return [subjectMatcher matchesView:view] && [self testMatcherMatchesASubviewOf:view];
}

-(BOOL) testMatcherMatchesASubviewOf:(UIView*)view {
    for(id subview in [view subviews]) {
        NSMutableSet* matchingDescendants = [NSMutableSet set];
        [[TreeWalker alloc] findViewsThatMatch:subtreeMatcher fromRoot:subview intoSet:matchingDescendants];
        if([matchingDescendants count] > 0) {
            return YES;
        }
    }
    return NO;
}

+(SubjectSubtreeMatcher*) withSubjectMatcher:(id<Matcher>)subjectMatcher subtreeMatcher:(id<Matcher>)subtreeMatcher {
    return [[SubjectSubtreeMatcher alloc] initWithSubjectMatcher:subjectMatcher subtreeMatcher:subtreeMatcher];
}

@end
