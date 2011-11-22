//
//  Created by Dale on 11/4/11.
//

#import <UIKit/UIKit.h>
#import "Igor.h"

@interface PropertyPatternTests : SenTestCase
@end

@implementation PropertyPatternTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

- (void) testPropertyExistsPattern {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    
    NSArray* selectedViews = [[Igor new] selectViewsWithSelector:@"[accessibilityHint]" fromRoot:view];
    assertThat(selectedViews, hasItem(view));
    
    selectedViews = [[Igor new] selectViewsWithSelector:@"[nonExistentProperty]" fromRoot:view];
    assertThat(selectedViews, isNot(hasItem(view)));
}

-(void) testPropertyValueEqualsPattern {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    view.accessibilityHint = @"monkeymonkey";
    
    NSArray* selectedViews = [[Igor new] selectViewsWithSelector:@"[accessibilityHint='monkeymonkey']"
                                                        fromRoot:view];
    assertThat(selectedViews, hasItem(view));
    
    selectedViews = [[Igor new] selectViewsWithSelector:@"[nonExistentProperty='fiddlefaddle']"
                                               fromRoot:view];
    assertThat(selectedViews, isNot(hasItem(view)));
}

@end
