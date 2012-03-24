#import "Igor.h"
#import "ViewFactory.h"

@interface SubjectAndDescendantPatternTests : SenTestCase
@end

@implementation SubjectAndDescendantPatternTests {
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

- (void)testMatchesIfTheViewMatchesTheSubjectPatternAndHasASubviewThatMatchesTheSubtreePattern {
    NSArray *nodeWithMiddleDescendant = [igor findViewsThatMatchPattern:@"*! [accessibilityHint='middle']" fromRoot:root];
    expect(nodeWithMiddleDescendant).toContain(root);
    expect(nodeWithMiddleDescendant).Not.toContain(middle);
    expect(nodeWithMiddleDescendant).Not.toContain(leaf);
}

- (void)testMatchesEachViewThatMatchesTheSubjectPatternAndHasASubviewThatMatchesTheSubtreePattern {
    NSArray *nodeWithLeafDescendant = [igor findViewsThatMatchPattern:@"*! [accessibilityHint='leaf']" fromRoot:root];
    expect(nodeWithLeafDescendant).toContain(root);
    expect(nodeWithLeafDescendant).toContain(middle);
    expect(nodeWithLeafDescendant).Not.toContain(leaf);
}

- (void)testSubtreeMatchesOnlyWithinSubjectSubviews {
    NSArray *middleWithLeafInsideMiddleDescendant = [igor findViewsThatMatchPattern:@"[accessibilityHint='middle']! [accessibilityHint='middle'] [accessibilityHint='leaf']" fromRoot:root];
    expect(middleWithLeafInsideMiddleDescendant).Not.toContain(middle);
    expect(middleWithLeafInsideMiddleDescendant.count).toEqual(0);
}

@end
