#import "Igor.h"
#import "ViewFactory.h"

@interface PredicatePatternTests : SenTestCase
@end

@implementation PredicatePatternTests {
    Igor *igor;
    UIView *view;
}

- (void)setUp {
    igor = [Igor igor];
    view = [ViewFactory buttonWithAccessibilityHint:@"the right accessibility hint"];
}

- (void)testMatchesSubjectThatSatisfiesPredicate {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='the right accessibility hint']" inTree:view];
    assertThat(matchingViews, hasItem(view));
}

- (void)testMismatchesSubjectThatDoesNotSatisfyPredicate {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='wrong accessibility hint']" inTree:view];
    assertThat(matchingViews, is(empty()));
}

- (void)testThrowsIfPatternIsIllegal {
    STAssertThrows([igor findViewsThatMatchQuery:@"[this is not a valid predicate]" inTree:nil], @"Expected predicate parsing exception");
}
@end
