#import "Igor.h"
#import "ViewFactory.h"

@interface PredicatePatternTests : SenTestCase
@end

@implementation PredicatePatternTests {
    Igor *igor;
    UIView *view;
}

- (void)setUp {
    igor = [Igor new];
    view = [ViewFactory buttonWithAccessibilityHint:@"the right accessibility hint"];
}

- (void)testMatchesSubjectThatSatisfiesPredicate {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='the right accessibility hint']" fromRoot:view];
    assertThat(matchingViews, hasItem(view));
}

- (void)testMismatchesSubjectThatDoesNotSatisfyPredicate {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='wrong accessibility hint']" fromRoot:view];
    assertThat(matchingViews, is(empty()));
}

- (void)testThrowsIfPatternIsIllegal {
    STAssertThrows([igor findViewsThatMatchPattern:@"[this is not a valid predicate]" fromRoot:nil], @"Expected predicate parsing exception");
}
@end
