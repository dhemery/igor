#import "Igor.h"
#import "ViewFactory.h"

@interface SubjectAndAncestorPatternTests : SenTestCase
@end

@implementation SubjectAndAncestorPatternTests {
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
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] [accessibilityHint='middle']" fromRoot:root];
    assertThat(matchingViews, hasItem(middle));
}

- (void)testMatchesMatchingSubjectsWithMatchingAncestors {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] [accessibilityHint='leaf']" fromRoot:root];
    assertThat(matchingViews, hasItem(leaf));
}

- (void)testRequiresMatchingAncestor {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='no such ancestor'] [accessibilityHint='leaf']" fromRoot:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testRequiresMatchingSubject {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] [accessibilityHint='no such subject']" fromRoot:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testMatchesAcrossUniversalClassMatcher {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] * [accessibilityHint='leaf']" fromRoot:root];
    assertThat(matchingViews, hasItem(leaf));
}

- (void)testRequiresMatchForEachUniversalClassMatcher {
    NSArray *matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='root'] * * [accessibilityHint='leaf']" fromRoot:root];
    assertThat(matchingViews, is(empty()));
}

@end
