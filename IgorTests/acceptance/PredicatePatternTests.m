#import "DEIgor.h"
#import "ViewFactory.h"

@interface PredicatePatternTests : XCTestCase
@end

@implementation PredicatePatternTests {
    DEIgor *igor;
    UIView *view;
}

- (void)setUp {
    igor = [DEIgor igor];
    view = [ViewFactory button];
    view.accessibilityHint = @"the right accessibility hint";
}

- (void)testMatchesSubjectThatSatisfiesPredicate {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='the right accessibility hint']" inTree:view];
    assertThat(matchingViews, hasItem(view));
}

- (void)testMismatchesSubjectThatDoesNotSatisfyPredicate {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='wrong accessibility hint']" inTree:view];
    assertThat(matchingViews, isEmpty());
}

- (void)testThrowsIfPatternIsIllegal {
    XCTAssertThrows([igor findViewsThatMatchQuery:@"[this is not a valid predicate]" inTree:nil], @"Some Monkey");
}
@end
