#import "ViewFactory.h"
#import "SubjectMatcher.h"
#import "IdentityMatcher.h"
#import "Combinator.h"
#import "IdentityCombinator.h"
#import "FalseMatcher.h"
#import "UniversalMatcher.h"

@interface IdentityCombinatorTests : SenTestCase
@end

@implementation IdentityCombinatorTests {
    NSMutableArray *matchingRelatives;
    NSMutableArray *targetViews;
}

- (void)setUp {
    matchingRelatives = [NSMutableArray array];
    targetViews = [NSMutableArray array];
}

- (void)testDeliversViewIfViewMatchesInstanceMatcher {
    UIView *view1 = [ViewFactory view];
    UIView *view2 = [ViewFactory view];
    [targetViews addObject:view1];
    [targetViews addObject:view2];
    id <Combinator> combinator = [IdentityCombinator combinatorThatAppliesMatcher:[UniversalMatcher new]];

    [combinator collectMatchingRelativesOfViews:targetViews inTree:nil intoArray:matchingRelatives];

    assertThat(matchingRelatives, contains(sameInstance(view1), sameInstance(view2), nil));
}

- (void)testReportsViewsDeliveredIfViewsDelivered {
    UIView *view1 = [ViewFactory view];
    [targetViews addObject:view1];
    id <Combinator> combinator = [IdentityCombinator combinatorThatAppliesMatcher:[UniversalMatcher new]];

    BOOL delivered = [combinator collectMatchingRelativesOfViews:targetViews inTree:nil intoArray:matchingRelatives];

    assertThatBool(delivered, equalToBool(YES));
}

- (void)testDeliversNoViewIfViewMismatchesInstanceMatcher {
    UIView *view = [ViewFactory view];
    [targetViews addObject:view];
    id <Combinator> combinator = [IdentityCombinator combinatorThatAppliesMatcher:[FalseMatcher new]];

    [combinator collectMatchingRelativesOfViews:targetViews inTree:nil intoArray:matchingRelatives];

    assertThat(matchingRelatives, is(empty()));
}

- (void)testReportsNoViewsDeliveredIfNoViewsDelivered {
    UIView *view1 = [ViewFactory view];
    [targetViews addObject:view1];
    id <Combinator> combinator = [IdentityCombinator combinatorThatAppliesMatcher:[FalseMatcher new]];

    BOOL delivered = [combinator collectMatchingRelativesOfViews:targetViews inTree:nil intoArray:matchingRelatives];

    assertThatBool(delivered, equalToBool(NO));
}

@end