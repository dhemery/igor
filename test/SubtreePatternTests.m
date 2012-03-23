
#import "Igor.h"

@interface SubtreePatternTests : SenTestCase
@end

@implementation SubtreePatternTests {
    Igor* igor;
}

-(void) setUp {
    igor = [Igor new];
}

-(void) testSubtree {
//    UIView* top = [ViewFactory buttonWithAccessibilityHint:@"top"];
//
//    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"([accessibilityHint='A'] [accessibilityHint='B'])" fromRoot:top];
}

@end
