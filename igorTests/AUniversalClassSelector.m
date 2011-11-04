//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AUniversalClassSelector.h"
#import "UniversalClassSelector.h"


@implementation AUniversalClassSelector {
    CGRect viewRect;
    UniversalClassSelector *selector;
    UIView* aUIView;
}

-(void) setUp {
    viewRect = CGRectMake(0, 0, 100, 100);
    selector = [UniversalClassSelector new];
    aUIView = [[UIView alloc] initWithFrame:viewRect];
}

-(void)testMatchesAnyViewClass {
    STAssertTrue([selector matches:aUIView], @"Matches a aUIView");
}

@end