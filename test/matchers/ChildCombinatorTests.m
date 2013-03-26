#import "ViewFactory.h"
#import "DEDescendantCombinator.h"
#import "DEChildCombinator.h"

@interface ChildCombinatorTests : SenTestCase
@end

@implementation ChildCombinatorTests {
    id <DECombinator> childCombinator;
    id subject;
}

- (void)setUp {
    childCombinator = [DEChildCombinator new];
    subject = [ViewFactory viewWithName:@"subject"];
}

- (void)testNoRelativesIfNoChildren {
    NSArray *relatives = [childCombinator relativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testChildIsRelativeIfOneChild {
    id onlyChild = [ViewFactory viewWithName:@"child"];
    [subject addSubview:onlyChild];

    NSArray *relatives = [childCombinator relativesOfView:subject];

    assertThat(relatives, contains(sameInstance(onlyChild), nil));
}

- (void)testAllChildrenAreRelatives {
    id child1 = [ViewFactory viewWithName:@"child 1"];
    id child2 = [ViewFactory viewWithName:@"child 2"];
    id child3 = [ViewFactory viewWithName:@"child 3"];
    id child4 = [ViewFactory viewWithName:@"child 4"];
    id child5 = [ViewFactory viewWithName:@"child 5"];
    [subject addSubview:child1];
    [subject addSubview:child2];
    [subject addSubview:child3];
    [subject addSubview:child4];
    [subject addSubview:child5];

    NSArray *relatives = [childCombinator relativesOfView:subject];

    assertThat(relatives, containsInAnyOrder(
            sameInstance(child1),
            sameInstance(child2),
            sameInstance(child3),
            sameInstance(child4),
            sameInstance(child5),
            nil));
}

- (void)testGrandchildrenAreNotRelatives {
    id child = [ViewFactory viewWithName:@"child"];
    id grandchild = [ViewFactory viewWithName:@"grandchild"];
    [subject addSubview:child];
    [child addSubview:grandchild];

    NSArray *relatives = [childCombinator relativesOfView:subject];

    assertThat(relatives, isNot(hasItem(grandchild)));
}

- (void)testNoInverseRelativesIfNoParent {
    NSArray *relatives = [childCombinator inverseRelativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testParentIsInverseRelative {
    id parent = [ViewFactory viewWithName:@"parent"];
    [parent addSubview:subject];

    NSArray *relatives = [childCombinator inverseRelativesOfView:subject];

    assertThat(relatives, contains(sameInstance(parent), nil));
}

- (void)testGrandParentIsNotInverseRelative {
    id parent = [ViewFactory viewWithName:@"parent"];
    id grandparent = [ViewFactory viewWithName:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [childCombinator inverseRelativesOfView:subject];

    assertThat(relatives, isNot(hasItem(grandparent)));
}

@end

