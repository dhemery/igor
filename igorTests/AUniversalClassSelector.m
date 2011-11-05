//
//  Created by Dale on 11/4/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
#import "AUniversalClassSelector.h"
#import "../igor/ViewSelector.h"


@implementation AUniversalClassSelector {
    CGRect frame;
    ViewSelector *universalClassSelector;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    universalClassSelector = [ViewSelector selectorFor:@"*"];
}

- (void) testAUniversalClassSelectorSelectsTheRootViewAndAllSubviews {
    UIView *root = [[UIView alloc] initWithFrame:frame];
    UIView *view1 = [[UIView alloc] initWithFrame: frame];
    UIView *view11 = [[UIView alloc] initWithFrame:frame];
    UIView *view12 = [[UIView alloc] initWithFrame:frame];
    UIView *view2 = [[UIView alloc] initWithFrame: frame];
    UIView *view21 = [[UIView alloc] initWithFrame:frame];
    UIView *view22 = [[UIView alloc] initWithFrame:frame];
    UIView *view23 = [[UIView alloc] initWithFrame:frame];

    [root addSubview:view1];
        [view1 addSubview:view11];
        [view1 addSubview:view12];
    [root addSubview:view2];
        [view2 addSubview:view21];
        [view2 addSubview:view22];
        [view2 addSubview:view23];

    NSMutableSet *selectedViews = [universalClassSelector selectViewsFromRoot:root];

    STAssertNotNil([selectedViews member:root], @"root");
    STAssertNotNil([selectedViews member:view1], @"view1");
    STAssertNotNil([selectedViews member:view11], @"view11");
    STAssertNotNil([selectedViews member:view12], @"view12");
    STAssertNotNil([selectedViews member:view2], @"view2");
    STAssertNotNil([selectedViews member:view21], @"view21");
    STAssertNotNil([selectedViews member:view22], @"view22");
    STAssertNotNil([selectedViews member:view23], @"view23");
}
@end