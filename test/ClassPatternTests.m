#import "Igor.h"
#import "ViewFactory.h"

@interface ClassPatternTests : SenTestCase
@end

@implementation ClassPatternTests {
    CGRect frame;
    Igor *igor;
}

- (void)setUp {
    frame = CGRectMake(0, 0, 100, 100);
    igor = [Igor new];
}

- (void)testAnyClassPattern {
    NSString *pattern = @"*";

    UIView *root = [ViewFactory view];
    UIView *view1 = [ViewFactory view];
    UIView *view11 = [ViewFactory view];
    UIView *view12 = [ViewFactory view];
    UIView *view2 = [ViewFactory view];
    UIView *view21 = [ViewFactory view];
    UIView *view211 = [ViewFactory view];
    UIView *view212 = [ViewFactory view];
    UIView *view213 = [ViewFactory view];
    UIView *view22 = [ViewFactory view];
    UIView *view23 = [ViewFactory view];

    [root addSubview:view1];
    [view1 addSubview:view11];
    [view1 addSubview:view12];
    [root addSubview:view2];
    [view2 addSubview:view21];
    [view21 addSubview:view211];
    [view21 addSubview:view212];
    [view21 addSubview:view213];
    [view2 addSubview:view22];
    [view2 addSubview:view23];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:pattern fromRoot:root];

    assertThat(matchingViews, containsInAnyOrder(root, view1, view11, view12, view2, view21, view211, view212, view213, view22, view23, nil));
}

- (void)testMemberOfClassPattern {
    NSString *pattern = @"UIButton";

    UIView *view = [ViewFactory view];
    UIView *button = [ViewFactory button];
    UIView *imageView = [ViewFactory view];
    UIView *root = view;
    [root addSubview:button];
    [button addSubview:imageView];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:pattern fromRoot:root];

    assertThat(matchingViews, hasItem(button));
    assertThat(matchingViews, hasCountOf(1));
}

- (void)testKindOfClassPattern {
    NSString *pattern = @"UIControl*";

    UIView *viewOfBaseClassOfTargetClass = [ViewFactory view];
    UIControl *viewOfTargetClass = [ViewFactory control];
    UIView *viewOfClassDerivedFromTargetClass = [ViewFactory button];
    UIView *viewOfUnrelatedClass = [ViewFactory window];

    UIView *root = viewOfBaseClassOfTargetClass;
    [root addSubview:viewOfTargetClass];
    [root addSubview:viewOfClassDerivedFromTargetClass];
    [root addSubview:viewOfUnrelatedClass];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:pattern fromRoot:root];

    assertThat(matchingViews, hasItem(viewOfTargetClass));
    assertThat(matchingViews, hasItem(viewOfClassDerivedFromTargetClass));
    assertThat(matchingViews, isNot(hasItem(viewOfBaseClassOfTargetClass)));
    assertThat(matchingViews, isNot(hasItem(viewOfUnrelatedClass)));
}

@end