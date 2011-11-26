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
    
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint]" fromRoot:view];
    assertThat(matchingViews, hasItem(view));
    
    matchingViews = [igor findViewsThatMatchPattern:@"[nonExistentProperty]" fromRoot:view];
    assertThat(matchingViews, isNot(hasItem(view)));
}

-(void) testPropertyValueEqualsPattern {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    view.accessibilityHint = @"monkeymonkey";
    
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='monkeymonkey']" fromRoot:view];
    assertThat(matchingViews, hasItem(view));
    
    matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='fiddlefaddle']" fromRoot:view];
    assertThat(matchingViews, isNot(hasItem(view)));

    matchingViews = [igor findViewsThatMatchPattern:@"[nonExistentProperty='monkeymonkey']" fromRoot:view];
    assertThat(matchingViews, isNot(hasItem(view)));
}

@end
