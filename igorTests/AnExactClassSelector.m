//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
#import "AnExactClassSelector.h"
#import "UniversalClassSelector.h"
#import "../igor/ExactClassSelector.h"


@implementation AnExactClassSelector {
    CGRect viewRect;
    ExactClassSelector *selector;
}

-(void) setUp {
    viewRect = CGRectMake(0, 0, 100, 100);
}

-(void)testMatchesAViewOfTheSpecifiedClass {
    UIView* view = [[UIView alloc] initWithFrame:viewRect];
    selector = [[ExactClassSelector alloc] initWithClass:[UIView class]];
    STAssertTrue([selector matches:view], @"");
}

-(void)testDoesNotMatchAViewOfAnotherClass {
    UIButton* button = [[UIButton alloc] initWithFrame:viewRect];
    selector = [[ExactClassSelector alloc] initWithClass:[UIView class]];
    STAssertFalse([selector matches:button], @"");
}

@end