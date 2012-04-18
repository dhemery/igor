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
    igor = [Igor igor];
    root = [ViewFactory viewWithName:@"root"];
    middle = [ViewFactory viewWithName:@"middle"];
    leaf = [ViewFactory viewWithName:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testMarkerBeforeFirstInstancePattern {
    NSArray *nodeWithMiddleDescendant = [igor findViewsThatMatchQuery:@"$* #middle" inTree:root];
    assertThat(nodeWithMiddleDescendant, onlyContains(root, nil));
}

- (void)testMarkerBeforeNonFirstInstancePattern {
    NSArray *markedMiddleDescendant = [igor findViewsThatMatchQuery:@"* $#middle" inTree:root];
    assertThat(markedMiddleDescendant, onlyContains(middle, nil));
}

- (void)testMatchesEachViewThatMatchesTheSubjectPatternAndHasASubviewThatMatchesTheRelationshipPattern {
    NSArray *nodeWithLeafDescendant = [igor findViewsThatMatchQuery:@"$* #leaf" inTree:root];
    assertThat(nodeWithLeafDescendant, onlyContains(root, middle, nil));
}

- (void)testSubtreeMatchesOnlyWithinSubjectSubviews {
    NSArray *middleWithLeafInsideMiddleDescendant = [igor findViewsThatMatchQuery:@"$#middle #middle #leaf" inTree:root];
    assertThat(middleWithLeafInsideMiddleDescendant, is(empty()));
}

@end
