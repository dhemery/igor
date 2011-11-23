//
//  Created by Dale on 11/4/11.
//

#import <UIKit/UIKit.h>
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
    NSString* selector = @"*";

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

    NSArray *selectedViews = [igor selectViewsWithSelector:selector fromRoot:root];

    assertThat(selectedViews, hasItem(root));
    assertThat(selectedViews, hasItem(view1));
    assertThat(selectedViews, hasItem(view11));
    assertThat(selectedViews, hasItem(view12));
    assertThat(selectedViews, hasItem(view2));
    assertThat(selectedViews, hasItem(view21));
    assertThat(selectedViews, hasItem(view211));
    assertThat(selectedViews, hasItem(view212));
    assertThat(selectedViews, hasItem(view213));
    assertThat(selectedViews, hasItem(view22));
    assertThat(selectedViews, hasItem(view23));
}

- (void) testMemberOfClassPattern {
    NSString* pattern = @"UIButton";

    UIView* view = [[UIView alloc] initWithFrame:frame];
    UIView* button = [[UIButton alloc] initWithFrame: frame];
    UIView* imageView = [[UIImageView alloc] initWithFrame:frame];
    UIView* root = view;
    [root addSubview:button];
    [button addSubview:imageView];

    NSArray *selectedViews = [igor selectViewsWithSelector:pattern fromRoot:root];
    
    assertThat(selectedViews, hasItem(button));
    assertThat(selectedViews, isNot(hasItem(view)));
    assertThat(selectedViews, isNot(hasItem(imageView)));
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
    
    NSArray *selectedViews = [igor selectViewsWithSelector:pattern fromRoot:root];
    
    assertThat(selectedViews, isNot(hasItem(viewOfBaseClassOfTargetClass)));
    assertThat(selectedViews, hasItem(viewOfTargetClass));
    assertThat(selectedViews, hasItem(viewOfClassDerivedFromTargetClass));
    assertThat(selectedViews, isNot(hasItem(viewOfUnrelatedClass)));
}

@end