#include "DescendantCombinatorMatcher.h"
#include "IdentityMatcher.h"
#include "ViewFactory.h"

@interface DescendantCombinatorMatcherTests : SenTestCase
@end

@implementation DescendantCombinatorMatcherTests

- (void)testMatchesIfParentAndChildMatch {
    UIButton *top = [ViewFactory button];
    UIButton *matchingChild = [ViewFactory button];
    UIButton *mismatchingChild = [ViewFactory button];
    [top addSubview:matchingChild];
    [top addSubview:mismatchingChild];

    DescendantCombinatorMatcher *matcher = [DescendantCombinatorMatcher withAncestorMatcher:[IdentityMatcher forView:top] descendantMatcher:[IdentityMatcher forView:matchingChild]];

    expect([matcher matchesView:matchingChild withinTree:top]).toBeTruthy();
    expect([matcher matchesView:mismatchingChild withinTree:top]).toBeFalsy();
}

- (void)testMatchesIfAncestorAndDescendantMatch {
    UIButton *top = [ViewFactory button];
    UIButton *interveningView = [ViewFactory button];
    UIButton *matchingDescendant = [ViewFactory button];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];

    DescendantCombinatorMatcher *matcher = [DescendantCombinatorMatcher withAncestorMatcher:[IdentityMatcher forView:top] descendantMatcher:[IdentityMatcher forView:matchingDescendant]];

    expect([matcher matchesView:top withinTree:top]).toBeFalsy();
    expect([matcher matchesView:interveningView withinTree:top]).toBeFalsy();
    expect([matcher matchesView:matchingDescendant withinTree:top]).toBeTruthy();
}

- (void)testMismatchesIfChildMatchesButParentDoesNot {
    UIButton *parent = [ViewFactory button];
    UIButton *child = [ViewFactory button];
    [parent addSubview:child];

    DescendantCombinatorMatcher *matcher = [DescendantCombinatorMatcher withAncestorMatcher:[IdentityMatcher forView:child] descendantMatcher:[IdentityMatcher forView:child]];

    expect([matcher matchesView:child withinTree:parent]).toBeFalsy();
}

@end
