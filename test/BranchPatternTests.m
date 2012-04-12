#import "ViewFactory.h"
#import "Igor.h"

@interface BranchPatternTests : SenTestCase
@end

@implementation BranchPatternTests {
    Igor *igor;
    UIView *root;
    UIView *middle;
    UIView *leaf;
}

- (void)setUp {
    igor = [Igor igor];
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testBranchAroundOnlySubjectPattern {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"([accessibilityHint='middle'])" inTree:root];
    assertThat(matchingViews, hasItem(middle));
    assertThat(matchingViews, hasCountOf(1));
}

@end