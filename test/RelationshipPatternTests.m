#import "Igor.h"
#import "ViewFactory.h"

@interface RelationshipPatternTests : SenTestCase
@end

@implementation RelationshipPatternTests {
    Igor *igor;
    UIView *root;
    UIView *middle;
    UIView *leaf;
}

- (void)setUp {
    igor = [Igor new];
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testMatchesMatchingSubjectsWithMatchingParent {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='root'] [accessibilityHint='middle']" inTree:root];
    assertThat(matchingViews, hasItem(middle));
}

- (void)testMatchesMatchingSubjectsWithMatchingAncestors {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='root'] [accessibilityHint='leaf']" inTree:root];
    assertThat(matchingViews, hasItem(leaf));
}

- (void)testRequiresMatchingAncestor {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='no such ancestor'] [accessibilityHint='leaf']" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testRequiresMatchingSubject {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='root'] [accessibilityHint='no such subject']" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testMatchesAcrossUniversalClassMatcher {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='root'] * [accessibilityHint='leaf']" inTree:root];
    assertThat(matchingViews, hasItem(leaf));
}

- (void)testRequiresMatchForEachUniversalClassMatcher {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"[accessibilityHint='root'] * * [accessibilityHint='leaf']" inTree:root];
    assertThat(matchingViews, is(empty()));
}

@end
