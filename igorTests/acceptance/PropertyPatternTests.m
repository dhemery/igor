//
//  Created by Dale on 11/4/11.
//

#import <UIKit/UIKit.h>
#import "Igor.h"

@interface PropertyPatternTests : SenTestCase
@end

@implementation PropertyPatternTests {
    CGRect frame;
    Igor* igor;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    igor = [Igor new];
}

- (void) testPropertyExistsPattern {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    
    NSArray* selectedViews = [igor selectViewsWithSelector:@"[accessibilityHint]" fromRoot:view];
    assertThat(selectedViews, hasItem(view));
    
    selectedViews = [igor selectViewsWithSelector:@"[nonExistentProperty]" fromRoot:view];
    assertThat(selectedViews, isNot(hasItem(view)));
}

-(void) testPropertyValueEqualsPattern {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    view.accessibilityHint = @"monkeymonkey";
    
    NSArray* selectedViews = [igor selectViewsWithSelector:@"[accessibilityHint='monkeymonkey']" fromRoot:view];
    assertThat(selectedViews, hasItem(view));
    
    selectedViews = [igor selectViewsWithSelector:@"[accessibilityHint='fiddlefaddle']" fromRoot:view];
    assertThat(selectedViews, isNot(hasItem(view)));

    selectedViews = [igor selectViewsWithSelector:@"[nonExistentProperty='monkeymonkey']" fromRoot:view];
    assertThat(selectedViews, isNot(hasItem(view)));
}

@end
