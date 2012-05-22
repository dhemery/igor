#import "ViewFactory.h"
#import "DEIgor.h"

@interface BranchPatternTests : SenTestCase
@end

@implementation BranchPatternTests {
    DEIgor *igor;
    UIView *root;
    UIView *middle1;
    UIView *middle1leaf1;
    UIView *middle1leaf2;
    UIView *middle2;
    UIView *middle2leaf1;
    UIView *middle2leaf2;
}

- (void)setUp {
    igor = [DEIgor igor];
    root = [ViewFactory viewWithName:@"root"];
    middle1 = [ViewFactory viewWithName:@"middle1"];
    middle1leaf1 = [ViewFactory viewWithName:@"middle1leaf1"];
    middle1leaf2 = [ViewFactory viewWithName:@"middle1leaf2"];
    middle2 = [ViewFactory viewWithName:@"middle2"];
    middle2leaf1 = [ViewFactory viewWithName:@"middle2leaf1"];
    middle2leaf2 = [ViewFactory viewWithName:@"middle2leaf2"];
    [root addSubview:middle1];
    [middle1 addSubview:middle1leaf1];
    [middle1 addSubview:middle1leaf2];
    [root addSubview:middle2];
    [middle2 addSubview:middle2leaf1];
    [middle2 addSubview:middle2leaf2];
}

- (void)testBranchAroundOnlySubjectPattern {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#middle1)" inTree:root];

    assertThat(matchingViews, contains(sameInstance(middle1), nil));
}

- (void)testSubjectMatchesViewTailMatchesRelative {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#middle1 #middle1leaf1)" inTree:root];

    assertThat(matchingViews, contains(sameInstance(middle1), nil));
}

- (void)testSubjectMatchesViewTailMismatchesRelatives {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#middle1 #nosuch)" inTree:root];

    assertThat(matchingViews, is(empty()));
}

- (void)testSubjectMatchesViewBranchMatchesSubjectAndRelatives {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#root #middle1leaf1) #middle2leaf1" inTree:root];

    assertThat(matchingViews, contains(sameInstance(middle2leaf1), nil));
}

- (void)testTailHasAChainOfDescendantMatchers {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#root #middle1 #middle1leaf1)" inTree:root];

    assertThat(matchingViews, contains(sameInstance(root), nil));
}

- (void)testTailHasAChainOfChildMatchers {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#root > #middle1 > #middle1leaf1)" inTree:root];

    assertThat(matchingViews, contains(sameInstance(root), nil));
}

- (void)testSubjectMatchesViewHeadBranchMatchesSubjectMismatchesDescendants {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#root #nosuch) #middle2 leaf1" inTree:root];

    assertThat(matchingViews, is(empty()));
}

- (void)testSubjectMatchesViewWithinAncestorBranchSubjects {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root (#middle1 #middle1leaf1) #middle1leaf2" inTree:root];

    assertThat(matchingViews, contains(sameInstance(middle1leaf2), nil));
}

- (void)testBranchMatchesViewsButQueryMatchesNoSubjectsInsideBranchSubjects {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#root (#middle1 #middle1leaf1) #middle2leaf2" inTree:root];

    assertThat(matchingViews, is(empty()));
}

- (void)testSiblingBranchesInQuery {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#root #middle1leaf1) (#middle2 #middle2leaf1)" inTree:root];

    assertThat(matchingViews, contains(sameInstance(middle2), nil));
}

- (void)testNestedBranchesInQuery {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"(#root (#middle1 #middle1leaf1)) #middle2" inTree:root];

    assertThat(matchingViews, contains(sameInstance(middle2), nil));
}

@end
