//
//  SubjectTestMatcher.m
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "SubjectTestMatcher.h"

@implementation SubjectTestMatcher
    @synthesize subject, test, igor;

- (BOOL)theTestMatcherMatchesASubviewOf:(UIView*)view {
    for(id subview in [view subviews]) {
        NSMutableSet* matchingDescendants = [NSMutableSet set];
        [igor findViewsThatMatch:test fromRoot:subview intoSet:matchingDescendants];
        if([matchingDescendants count] > 0) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)matchesView:(UIView *)view {
    return [subject matchesView:view] && [self theTestMatcherMatchesASubviewOf:view];
}

-(id) initForSubject:(id<Matcher>)subjectMatcher test:(id<Matcher>)testMatcher igor:(Igor*)theIgor {
    if(self = [super init]) {
        subject = subjectMatcher;
        test = testMatcher;
        igor = theIgor;
    }
    return self;
}

+(id) forSubject:(id<Matcher>)subjectMatcher test:(id<Matcher>)testMatcher igor:(Igor*)igor {
    return [[SubjectTestMatcher alloc] initForSubject:subjectMatcher test:testMatcher igor:igor];
}

@end
