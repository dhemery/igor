#import "DEIgor.h"
#import "ViewFactory.h"

@interface DescendantPatternTests : SenTestCase
@end

@implementation DescendantPatternTests {
    DEIgor *igor;
    id root;
    id middle;
    id leaf;
}

- (void)setUp {
    igor = [DEIgor igor];
    root = [ViewFactory viewWithName:@"root"];
    middle = [ViewFactory viewWithName:@"middle"];
    leaf = [ViewFactory viewWithName:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (void)testDescendantCombinatorMatchesMatchingSubjectWithMatchingAncestor {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root #middle" inTree:root];
    assertThat(matchingViews, hasItem(middle));
}

- (void)testDescendantCombinatorRequiresMatchingSubject {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root #nosuch" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testDescendantCombinatorRequiresMatchingAncestor {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#nosuch #leaf" inTree:root];
    assertThat(matchingViews, isNot(hasItem(leaf)));
}

- (void)testDescendantCombinatorChainSatisfiedIfEachAncestorPatternMatchesAHigherAncestor {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root #middle #leaf" inTree:root];
    assertThat(matchingViews, hasItem(leaf));
}

- (void)testDescendantCombinatorChainRequiresAMatchForEachAncestorPattern {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root * * #leaf" inTree:root];
    assertThat(matchingViews, is(empty()));
}

@end
