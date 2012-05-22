#import "DEIgor.h"
#import "ViewFactory.h"

@interface SiblingPatternTests : SenTestCase
@end

@implementation SiblingPatternTests {
    DEIgor *igor;
    UIView *root;
    UIView *middle1;
    UIView *middle2;
    UIView *middle3;
    UIView *middle4;
    UIView *middle5;
}

- (void)setUp {
    igor = [DEIgor igor];
    root = [ViewFactory viewWithName:@"root"];
    middle1 = [ViewFactory viewWithName:@"middle1"];
    middle2 = [ViewFactory viewWithName:@"middle2"];
    middle3 = [ViewFactory viewWithName:@"middle3"];
    middle4 = [ViewFactory viewWithName:@"middle4"];
    middle5 = [ViewFactory viewWithName:@"middle5"];
    [root addSubview:middle1];
    [root addSubview:middle2];
    [root addSubview:middle3];
    [root addSubview:middle4];
    [root addSubview:middle5];
}

- (void)testSiblingCombinatorMatchesMatchingSubjectWithMatchingSibling {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#middle1 ~ *" inTree:root];

    assertThat(matchingViews,
        containsInAnyOrder(
            sameInstance(middle2),
            sameInstance(middle3),
            sameInstance(middle4),
            sameInstance(middle5),
            nil));
}

- (void)testSiblingCombinatorRequiresMatchingSubject {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"* ~ #nosuch" inTree:root];

    assertThat(matchingViews, is(empty()));
}

- (void)testSiblingCombinatorRequiresMatchingSibling {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#nosuch ~ *" inTree:root];

    assertThat(matchingViews, is(empty()));
}

- (void)testSiblingCombinatorChainMatchesEntireBrood {
    NSArray *matchingViews = [igor findViewsThatMatchQuery:@"#middle1 ~ * ~ *" inTree:root];

    assertThat(matchingViews,
        containsInAnyOrder(
            sameInstance(middle1),
            sameInstance(middle2),
            sameInstance(middle3),
            sameInstance(middle4),
            sameInstance(middle5),
            nil));
}

@end
