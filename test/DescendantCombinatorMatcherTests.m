//
//  DescendantCombinatorMatcherTests.m
//  igor
//
//  Created by Dale Emery on 3/8/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#include "PredicateMatcher.h"
#include "DescendantCombinatorMatcher.h"

@interface DescendantCombinatorMatcherTests : SenTestCase
@end

@implementation DescendantCombinatorMatcherTests {
    CGRect frame;
    id ancestorMatcher;
    id descendantMatcher;
    id descendantCombinatorMatcher;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    ancestorMatcher = [PredicateMatcher forPredicateExpression:@"accessibilityHint='ancestor'"];
    descendantMatcher = [PredicateMatcher forPredicateExpression:@"accessibilityHint='descendant'"];
    descendantCombinatorMatcher = [DescendantCombinatorMatcher forAncestorMatcher:ancestorMatcher descendantMatcher:descendantMatcher];
}

- (id) buttonWithAccessibilityHint:(NSString*)hint {
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    button.accessibilityHint = hint;
    return button;
}

- (void)testMatchesIfParentAndChildMatch {
    UIButton* top = [self buttonWithAccessibilityHint:@"ancestor"];
    UIButton* matchingChild1 = [self buttonWithAccessibilityHint:@"descendant"];
    UIButton* matchingChild2 = [self buttonWithAccessibilityHint:@"descendant"];
    UIButton* mismatchingChild = [self buttonWithAccessibilityHint:@"does not match"];
    [top addSubview:matchingChild1];
    [top addSubview:matchingChild2];
    [top addSubview:mismatchingChild];
    expect([descendantCombinatorMatcher matchesView:matchingChild1]).toBeTruthy();
    expect([descendantCombinatorMatcher matchesView:matchingChild2]).toBeTruthy();
    expect([descendantCombinatorMatcher matchesView:mismatchingChild]).toBeFalsy();
}

- (void)testMatchesIfAncestorAndDescendantMatch {
    UIButton* top = [self buttonWithAccessibilityHint:@"does not match"];
    UIButton* matchingAncestor = [self buttonWithAccessibilityHint:@"ancestor"];
    UIButton* interveningAncestor = [self buttonWithAccessibilityHint:@"does not match"];
    UIButton* matchingDescendant = [self buttonWithAccessibilityHint:@"descendant"];
    [top addSubview:matchingAncestor];
    [matchingAncestor addSubview:interveningAncestor];
    [interveningAncestor addSubview:matchingDescendant];
    expect([descendantCombinatorMatcher matchesView:top]).toBeFalsy();
    expect([descendantCombinatorMatcher matchesView:matchingAncestor]).toBeFalsy();
    expect([descendantCombinatorMatcher matchesView:interveningAncestor]).toBeFalsy();
    expect([descendantCombinatorMatcher matchesView:matchingDescendant]).toBeTruthy();
}

- (void)testMismatchesIfChildMatchesButParentDoesNot {
    UIButton* parent = [self buttonWithAccessibilityHint:@"does not match"];
    UIButton* child = [self buttonWithAccessibilityHint:@"descendant"];
    [parent addSubview:child];
    expect([descendantCombinatorMatcher matchesView:child]).toBeFalsy();
}

@end
