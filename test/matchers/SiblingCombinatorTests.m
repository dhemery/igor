#import "DECombinator.h"
#import "ViewFactory.h"
#import "DESiblingCombinator.h"

@interface SiblingCombinatorTests : SenTestCase
@end

@implementation SiblingCombinatorTests {
    id <DECombinator> siblingCombinator;
    UIView *subject;
    UIView *root;
}

- (void)setUp {
    siblingCombinator = [DESiblingCombinator new];
    root = [ViewFactory viewWithName:@"root"];
    subject = [ViewFactory viewWithName:@"subject"];
    [root addSubview:subject];
}

- (void)testNoRelativesIfNoSiblings {
    NSArray *relatives = [siblingCombinator relativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testSingleSiblingIsARelative {
    UIView *onlySibling = [ViewFactory viewWithName:@"sibling"];
    [root addSubview:onlySibling];

    NSArray *relatives = [siblingCombinator relativesOfView:subject];

    assertThat(relatives, hasItem(onlySibling));
}

- (void)testAllSiblingsAreRelatives {
    UIView *sibling1 = [ViewFactory viewWithName:@"sibling1"];
    UIView *sibling2 = [ViewFactory viewWithName:@"sibling2"];
    UIView *sibling3 = [ViewFactory viewWithName:@"sibling3"];
    UIView *sibling4 = [ViewFactory viewWithName:@"sibling4"];
    [root addSubview:sibling1];
    [root addSubview:sibling2];
    [root addSubview:sibling3];
    [root addSubview:sibling4];

    NSArray *relatives = [siblingCombinator relativesOfView:subject];

    assertThat(relatives,
        containsInAnyOrder(
            sameInstance(sibling1),
            sameInstance(sibling2),
            sameInstance(sibling3),
            sameInstance(sibling4),
            nil)
        );
}

- (void)testSubjectIsNotItsOwnSibling {
    NSArray *relatives = [siblingCombinator relativesOfView:subject];

    assertThat(relatives, isNot(hasItem(subject)));
}

- (void)testAllSiblingsAreInverseRelatives {
    UIView *sibling1 = [ViewFactory viewWithName:@"sibling1"];
    UIView *sibling2 = [ViewFactory viewWithName:@"sibling2"];
    UIView *sibling3 = [ViewFactory viewWithName:@"sibling3"];
    UIView *sibling4 = [ViewFactory viewWithName:@"sibling4"];
    [root addSubview:sibling1];
    [root addSubview:sibling2];
    [root addSubview:sibling3];
    [root addSubview:sibling4];

    NSArray *relatives = [siblingCombinator relativesOfView:subject];
    NSArray *inverseRelatives = [siblingCombinator inverseRelativesOfView:subject];

    assertThat(inverseRelatives, equalTo(relatives));
}

@end
