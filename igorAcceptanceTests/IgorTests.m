//
//  Created by Dale on 11/4/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
#import "IgorTests.h"
#import "Igor.h"


@implementation IgorTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

- (void) testAUniversalClassSelectorSelectsTheRootViewAndAllSubviews {
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
            [view2 addSubview:view211];
            [view2 addSubview:view212];
            [view2 addSubview:view213];
        [view2 addSubview:view22];
        [view2 addSubview:view23];

    Igor *igor = [Igor igorFor:@"*"];
    NSMutableSet *selectedViews = [igor selectViewsFromRoot:root];

    STAssertNotNil([selectedViews member:root], @"root");
    STAssertNotNil([selectedViews member:view1], @"view1");
    STAssertNotNil([selectedViews member:view11], @"view11");
    STAssertNotNil([selectedViews member:view12], @"view12");
    STAssertNotNil([selectedViews member:view2], @"view2");
    STAssertNotNil([selectedViews member:view21], @"view21");
    STAssertNotNil([selectedViews member:view211], @"view211");
    STAssertNotNil([selectedViews member:view212], @"view212");
    STAssertNotNil([selectedViews member:view213], @"view213");
    STAssertNotNil([selectedViews member:view22], @"view22");
    STAssertNotNil([selectedViews member:view23], @"view23");
}

- (void) testAClassEqualsSelectorSelectsOnlyViewsOfTheSpecifiedClass {
    UIView *root = [[UIView alloc] initWithFrame:frame];
    UIView *button = [[UIButton alloc] initWithFrame: frame];
    UIView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [root addSubview:button];
    [button addSubview:imageView];
    
    Igor *igor = [Igor igorFor:@"UIButton"];
    NSMutableSet *selectedViews = [igor selectViewsFromRoot:root];
    
    STAssertNil([selectedViews member:root], @"root");
    STAssertNotNil([selectedViews member:button], @"button");
    STAssertNil([selectedViews member:imageView], @"imageView");
    
}
@end