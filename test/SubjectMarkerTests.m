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

- (void)testMatchesIfTheViewMatchesTheSubjectPatternAndASubviewMatchesTheRelationshipPattern {
    NSArray *nodeWithMiddleDescendant = [igor findViewsThatMatchPattern:@"$* [accessibilityHint='middle']" fromRoot:root];
    assertThat(nodeWithMiddleDescendant, onlyContains(root, nil));
}

- (void)testMatchesEachViewThatMatchesTheSubjectPatternAndHasASubviewThatMatchesTheRelationshipPattern {
    NSArray *nodeWithLeafDescendant = [igor findViewsThatMatchPattern:@"$* [accessibilityHint='leaf']" fromRoot:root];
    assertThat(nodeWithLeafDescendant, onlyContains(root, middle, nil));
}

- (void)testSubtreeMatchesOnlyWithinSubjectSubviews {
    NSArray *middleWithLeafInsideMiddleDescendant = [igor findViewsThatMatchPattern:@"$[accessibilityHint='middle'] [accessibilityHint='middle'] [accessibilityHint='leaf']" fromRoot:root];
    assertThat(middleWithLeafInsideMiddleDescendant, is(empty()));
}

@end
