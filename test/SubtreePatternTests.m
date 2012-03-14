//
//  SubtreePatternTests.m
//  igor
//
//  Created by Dale Emery on 3/10/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"

@interface SubtreePatternTests : SenTestCase
@end

@implementation SubtreePatternTests {
    CGRect frame;
    Igor* igor;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    igor = [Igor new];
}

- (id) buttonWithAccessibilityHint:(NSString*)hint {
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    button.accessibilityHint = hint;
    return button;
}

-(void) testSubtree {
//    UIView* top = [self buttonWithAccessibilityHint:@"top"];
//
//    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='A'](. [accessibilityHint='B'])" fromRoot:top];
}

@end
