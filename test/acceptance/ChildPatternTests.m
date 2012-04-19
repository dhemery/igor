#import "Igor.h"
#import "ViewFactory.h"

@interface ChildPatternTests : SenTestCase
@end

@implementation ChildPatternTests {
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

- (void)testChildCombinatorMatchesMatchingSubjectWithMatchingParent {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root > #middle" inTree:root];
    assertThat(matchingViews, hasItem(middle));
}

- (void)testChildCombinatorRequiresMatchingSubject {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root > #nosuch" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testChildCombinatorRequiresMatchingParent {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#nosuch > #leaf" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testChildCombinatorChainSatisfiedIfEachParentPatternMatchesTheNextHigherParent {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root > #middle > #leaf" inTree:root];
    assertThat(matchingViews, hasItem(leaf));
}

- (void)testChildCombinatorChainRequiresAMatchForEachAncestorPattern {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root > * > * > #leaf" inTree:root];
    assertThat(matchingViews, is(empty()));
}

@end
