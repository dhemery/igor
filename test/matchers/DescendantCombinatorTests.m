#import "ViewFactory.h"
#import "DEDescendantCombinator.h"

@interface DescendantCombinatorTests : SenTestCase
@end

@implementation DescendantCombinatorTests {
    id <DECombinator> descendantCombinator;
    id subject;
}

- (void)setUp {
    descendantCombinator = [DEDescendantCombinator new];
    subject = [ViewFactory viewWithName:@"subject"];
}

- (void)testNoRelativesIfNoDescendants {
    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testChildIsRelativeIfOneChild {
    id child = [ViewFactory viewWithName:@"child"];
    [subject addSubview:child];

    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, contains(sameInstance(child), nil));
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

    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, contains(
            sameInstance(child1),
            sameInstance(child2),
            sameInstance(child3),
            sameInstance(child4),
            sameInstance(child5),
            nil));
}

- (void)testGrandchildrenAreRelatives {
    id child = [ViewFactory viewWithName:@"child"];
    id grandchild = [ViewFactory viewWithName:@"grandchild"];
    [subject addSubview:child];
    [child addSubview:grandchild];

    NSArray *relatives = [descendantCombinator relativesOfView:subject];

    assertThat(relatives, hasItem(sameInstance(grandchild)));
}

- (void)testNoInverseRelativesIfNoParent {
    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, is(empty()));
}

- (void)testParentIsInverseRelative {
    id parent = [ViewFactory viewWithName:@"parent"];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, contains(sameInstance(parent), nil));
}

- (void)testGrandParentIsInverseRelative {
    id parent = [ViewFactory viewWithName:@"parent"];
    id grandparent = [ViewFactory viewWithName:@"grandparent"];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, hasItem(grandparent));
}

- (void)testAllAncestorsAreInverseRelatives {
    id parent = [ViewFactory viewWithName:@"parent"];
    id grandparent = [ViewFactory viewWithName:@"grandparent"];
    id greatGrandparent = [ViewFactory viewWithName:@"great grandparent"];
    id greatGreatGrandparent = [ViewFactory viewWithName:@"great great grandparent"];
    id greatGreatGreatGrandparent = [ViewFactory viewWithName:@"great great great grandparent"];
    [greatGreatGreatGrandparent addSubview:greatGreatGrandparent];
    [greatGreatGrandparent addSubview:greatGrandparent];
    [greatGrandparent addSubview:grandparent];
    [grandparent addSubview:parent];
    [parent addSubview:subject];

    NSArray *relatives = [descendantCombinator inverseRelativesOfView:subject];

    assertThat(relatives, containsInAnyOrder(
                    sameInstance(greatGreatGreatGrandparent),
                    sameInstance(greatGreatGrandparent),
                    sameInstance(greatGrandparent),
                    sameInstance(grandparent),
                    sameInstance(parent),
                    nil));
}

@end
