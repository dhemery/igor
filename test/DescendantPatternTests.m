//
//  DescendantPatternTests.m
//  igor
//
//  Created by Dale Emery on 3/8/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"

@interface DescendantPatternTests : SenTestCase
@end

@implementation DescendantPatternTests {
CGRect frame;
Igor* igor;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    igor = [Igor new];
}

-(void) testFindsMatchingChildren {
    UIView* top = [[UIButton alloc] initWithFrame:frame];
    top.accessibilityHint = @"top";
    UIView* matchingSubview = [[UIButton alloc] initWithFrame:frame];
    matchingSubview.accessibilityHint = @"matches";
    UIView* nonMatchingSubview = [[UIButton alloc] initWithFrame:frame];
    nonMatchingSubview.accessibilityHint = @"does not match";
    [top addSubview:matchingSubview];
    [top addSubview:nonMatchingSubview];
    
//    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] [accessibilityLabelHint='matches']" fromRoot:top];
//    expect(matchingViews).toContain(matchingSubview);
//    expect(matchingViews).Not.toContain(nonMatchingSubview);
}


@end
