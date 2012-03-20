//
//  SubjectTestMatcher.m
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "SubjectTestMatcher.h"
#import "TreeWalker.h"

@implementation SubjectTestMatcher

@synthesize subject, test;

+(SubjectTestMatcher*) forSubject:(id<Matcher>)subjectMatcher test:(id<Matcher>)testMatcher {
    return [[SubjectTestMatcher alloc] initForSubject:subjectMatcher test:testMatcher];
}

-(SubjectTestMatcher*) initForSubject:(id<Matcher>)subjectMatcher test:(id<Matcher>)testMatcher {
    if(self = [super init]) {
        subject = subjectMatcher;
        test = testMatcher;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return [subject matchesView:view] && [self testMatcherMatchesASubviewOf:view];
}

-(BOOL) testMatcherMatchesASubviewOf:(UIView*)view {
    for(id subview in [view subviews]) {
        NSMutableSet* matchingDescendants = [NSMutableSet set];
        [[TreeWalker alloc] findViewsThatMatch:test fromRoot:subview intoSet:matchingDescendants];
        if([matchingDescendants count] > 0) {
            return YES;
        }
    }
    return NO;
}

@end
