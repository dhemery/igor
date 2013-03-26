#import "DEIgor.h"
#import "ViewFactory.h"

@interface PredicatePatternTests : SenTestCase
@end

@implementation PredicatePatternTests {
    DEIgor *igor;
    id view;
}

- (void)setUp {
    igor = [DEIgor igor];
    view = [ViewFactory button];
# if TARGET_OS_IPHONE
    [view setAccessibilityHint:@"the right accessibility hint"];
#else
    [view setTitle:@"the right title"];
#endif
}

- (void)testMatchesSubjectThatSatisfiesPredicate {
# if TARGET_OS_IPHONE
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='the right accessibility hint']" inTree:view];
#else
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[title='the right title']" inTree:view];
#endif
    assertThat(matchingViews, hasItem(view));
}

- (void)testMismatchesSubjectThatDoesNotSatisfyPredicate {
# if TARGET_OS_IPHONE
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='wrong accesibility hint']" inTree:view];
#else
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[title='the wrong title']" inTree:view];
#endif
    assertThat(matchingViews, is(empty()));
}

- (void)testThrowsIfPatternIsIllegal {
    STAssertThrows([igor findViewsThatMatchQuery:@"[this is not a valid predicate]" inTree:nil], nil);
}
@end
