//
//  DescendantCombinatorMatcherTests.m
//  igor
//
//  Created by Dale Emery on 3/8/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#include "IdentityMatcher.h"
#include "DescendantCombinatorMatcher.h"
#include "ViewFactory.h"

@interface DescendantCombinatorMatcherTests : SenTestCase
@end

@implementation DescendantCombinatorMatcherTests

- (void)testMatchesIfParentAndChildMatch {
    UIButton* top = [ViewFactory button];
    UIButton* matchingChild = [ViewFactory button];
    UIButton* mismatchingChild = [ViewFactory button];
    [top addSubview:matchingChild];
    [top addSubview:mismatchingChild];

    DescendantCombinatorMatcher* matcher = [DescendantCombinatorMatcher withAncestorMatcher:[IdentityMatcher forView:top]  descendantMatcher:[IdentityMatcher forView:matchingChild]];

    expect([matcher matchesView:matchingChild]).toBeTruthy();
    expect([matcher matchesView:mismatchingChild]).toBeFalsy();
}

- (void)testMatchesIfAncestorAndDescendantMatch {
    UIButton* top = [ViewFactory button];
    UIButton* interveningView = [ViewFactory button];
    UIButton* matchingDescendant = [ViewFactory button];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];
    
    DescendantCombinatorMatcher* matcher = [DescendantCombinatorMatcher withAncestorMatcher:[IdentityMatcher forView:top]  descendantMatcher:[IdentityMatcher forView:matchingDescendant]];
    
    expect([matcher matchesView:top]).toBeFalsy();
    expect([matcher matchesView:interveningView]).toBeFalsy();
    expect([matcher matchesView:matchingDescendant]).toBeTruthy();
}

- (void)testMismatchesIfChildMatchesButParentDoesNot {
    UIButton* parent = [ViewFactory button];
    UIButton* child = [ViewFactory button];
    [parent addSubview:child];

    DescendantCombinatorMatcher* matcher = [DescendantCombinatorMatcher withAncestorMatcher:[IdentityMatcher forView:child]  descendantMatcher:[IdentityMatcher forView:child]];
    
    expect([matcher matchesView:child]).toBeFalsy();
}

@end
