#import "Igor.h"
#import "ViewFactory.h"

@interface SubjectMarkerTests : SenTestCase
@end

@implementation SubjectMarkerTests {
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

- (void)testMarkerBeforeFirstInstancePattern {
    NSArray *nodeWithMiddleDescendant = [igor findViewsThatMatchQuery:@"$* [accessibilityHint='middle']" inTree:root];
    assertThat(nodeWithMiddleDescendant, onlyContains(root, nil));
}

- (void)testMarkerBeforeNonFirstInstancePattern {
    NSArray *markedMiddleDescendant = [igor findViewsThatMatchQuery:@"* $[accessibilityHint='middle']" inTree:root];
    assertThat(markedMiddleDescendant, onlyContains(middle, nil));
}

- (void)testMatchesEachViewThatMatchesTheSubjectPatternAndHasASubviewThatMatchesTheRelationshipPattern {
    NSArray *nodeWithLeafDescendant = [igor findViewsThatMatchQuery:@"$* [accessibilityHint='leaf']" inTree:root];
    assertThat(nodeWithLeafDescendant, onlyContains(root, middle, nil));
}

- (void)testSubtreeMatchesOnlyWithinSubjectSubviews {
    NSArray *middleWithLeafInsideMiddleDescendant = [igor findViewsThatMatchQuery:@"$[accessibilityHint='middle'] [accessibilityHint='middle'] [accessibilityHint='leaf']" inTree:root];
    assertThat(middleWithLeafInsideMiddleDescendant, is(empty()));
}

@end
