#import "Igor.h"
#import "ViewFactory.h"

@interface DescendantPatternTests : SenTestCase
@end

@implementation DescendantPatternTests {
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

- (void)testMatchesMatchingSubjectWithMatchingRelative {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root #middle" inTree:root];
    assertThat(matchingViews, hasItem(middle));
}

- (void)testRequiresMatchingRelative {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#nosuch #leaf" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testRequiresMatchingSubject {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root #nosuch" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testMatchesAcrossChain {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root #middle #leaf" inTree:root];
    assertThat(matchingViews, hasItem(leaf));
}

- (void)testRequiresMatchForEachMatcher {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root * * #leaf" inTree:root];
    assertThat(matchingViews, is(empty()));
}

@end
