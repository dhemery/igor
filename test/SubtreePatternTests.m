//
//  SubtreePatternTests.m
//  igor
//
//  Created by Dale Emery on 3/10/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"
#import "ViewFactory.h"

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
