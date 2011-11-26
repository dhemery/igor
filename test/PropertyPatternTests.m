//
//  Created by Dale on 11/4/11.
//

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
    expect(matchingViews).toContain(view);
    
    matchingViews = [igor findViewsThatMatchPattern:@"[nonExistentProperty]" fromRoot:view];
    expect(matchingViews).Not.toContain(view);
}

-(void) testPropertyValueEqualsPattern {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    view.accessibilityHint = @"monkeymonkey";
    
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='monkeymonkey']" fromRoot:view];
    expect(matchingViews).toContain(view);
    
    matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='fiddlefaddle']" fromRoot:view];
    expect(matchingViews).Not.toContain(view);

    matchingViews = [igor findViewsThatMatchPattern:@"[nonExistentProperty='monkeymonkey']" fromRoot:view];
    expect(matchingViews).Not.toContain(view);
}

@end
