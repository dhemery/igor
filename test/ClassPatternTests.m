//
//  Created by Dale on 11/4/11.
//

#import "Igor.h"

@interface ClassPatternTests : SenTestCase
@end

@implementation ClassPatternTests {
    CGRect frame;
    Igor* igor;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    igor = [Igor new];
}

- (void) testAnyClassPattern {
    NSString* pattern = @"*";

    UIView *root = [[UIView alloc] initWithFrame:frame];
    UIView *view1 = [[UIView alloc] initWithFrame: frame];
    UIView *view11 = [[UIView alloc] initWithFrame:frame];
    UIView *view12 = [[UIView alloc] initWithFrame:frame];
    UIView *view2 = [[UIView alloc] initWithFrame: frame];
    UIView *view21 = [[UIView alloc] initWithFrame:frame];
    UIView *view211 = [[UIView alloc] initWithFrame:frame];
    UIView *view212 = [[UIView alloc] initWithFrame:frame];
    UIView *view213 = [[UIView alloc] initWithFrame:frame];
    UIView *view22 = [[UIView alloc] initWithFrame:frame];
    UIView *view23 = [[UIView alloc] initWithFrame:frame];

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

    expect(matchingViews).toContain(root);
    expect(matchingViews).toContain(view1);
    expect(matchingViews).toContain(view11);
    expect(matchingViews).toContain(view12);
    expect(matchingViews).toContain(view2);
    expect(matchingViews).toContain(view21);
    expect(matchingViews).toContain(view211);
    expect(matchingViews).toContain(view212);
    expect(matchingViews).toContain(view213);
    expect(matchingViews).toContain(view22);
    expect(matchingViews).toContain(view23);
}

- (void) testMemberOfClassPattern {
    NSString* pattern = @"UIButton";

    UIView* view = [[UIView alloc] initWithFrame:frame];
    UIView* button = [[UIButton alloc] initWithFrame: frame];
    UIView* imageView = [[UIImageView alloc] initWithFrame:frame];
    UIView* root = view;
    [root addSubview:button];
    [button addSubview:imageView];

    NSArray *matchingViews = [igor findViewsThatMatchPattern:pattern fromRoot:root];
    
    expect(matchingViews).toContain(button);
    expect(matchingViews).Not.toContain(view);
    expect(matchingViews).Not.toContain(imageView);
}

- (void) testKindOfClassPattern {
    NSString* pattern = @"UIControl*";

    UIView *viewOfBaseClassOfTargetClass = [[UIView alloc] initWithFrame:frame];
    UIView *viewOfTargetClass = [[UIControl alloc] initWithFrame: frame];
    UIView *viewOfClassDerivedFromTargetClass = [[UIButton alloc] initWithFrame:frame];
    UIView *viewOfUnrelatedClass = [[UIWindow alloc] initWithFrame:frame];
    
    UIView* root = viewOfBaseClassOfTargetClass;
    [root addSubview:viewOfTargetClass];
    [root addSubview:viewOfClassDerivedFromTargetClass];
    [root addSubview:viewOfUnrelatedClass];
    
    NSArray *matchingViews = [igor findViewsThatMatchPattern:pattern fromRoot:root];
    
    expect(matchingViews).Not.toContain(viewOfBaseClassOfTargetClass);
    expect(matchingViews).toContain(viewOfTargetClass);
    expect(matchingViews).toContain(viewOfClassDerivedFromTargetClass);
    expect(matchingViews).Not.toContain(viewOfUnrelatedClass);
}

@end