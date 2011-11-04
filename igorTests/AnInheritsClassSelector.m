//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
#import "AnInheritsClassSelector.h"
#import "ExactClassSelector.h"
#import "InheritsClassSelector.h"


@implementation AnInheritsClassSelector {
    CGRect viewRect;
}

-(void) setUp {
    viewRect = CGRectMake(0, 0, 100, 100);
}

-(void)testMatchesAViewOfTheSpecifiedClass {
    UIView* view = [[UIView alloc] initWithFrame:viewRect];
    InheritsClassSelector *viewSelector = [[InheritsClassSelector alloc] initWithClass:[UIView class]];
    STAssertTrue([viewSelector matches:view], @"UIView isa UIView");
}

-(void)testMatchesAViewOfADerivedClass {
    UIButton* button = [[UIButton alloc] initWithFrame:viewRect];
    InheritsClassSelector *controlSelector = [[InheritsClassSelector alloc] initWithClass:[UIView class]];
    STAssertTrue([controlSelector matches:button], @"UIButton isa UIView");
}

-(void)testDoesNotMatchAViewOfANonDerivedClass {
    UIView* view = [[UIView alloc] initWithFrame:viewRect];
    InheritsClassSelector *viewSelector = [[InheritsClassSelector alloc] initWithClass:[UIControl class]];
    STAssertFalse([viewSelector matches:view], @"UIView isnota UIControl");
}

@end