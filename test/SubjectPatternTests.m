//
//  SubtreePatternTests.m
//  igor
//
//  Created by Dale Emery on 3/10/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"

@interface SubjectPatternTests : SenTestCase
@end

@implementation SubjectPatternTests {
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

-(void) testAllowsSubjectMarker {
    UIView* top = [self buttonWithAccessibilityHint:@"top"];
    UIView* viewA = [self buttonWithAccessibilityHint:@"A"];
    UIView* viewB = [self buttonWithAccessibilityHint:@"B"];

    [top addSubview:viewA];
    [viewA addSubview:viewB];

    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"*!" fromRoot:top];
    expect(matchingViews).toContain(top);
    expect(matchingViews).toContain(viewA);
    expect(matchingViews).toContain(viewB);
}

@end
