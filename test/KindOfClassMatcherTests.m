//
//  AKindOfClassSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "KindOfClassMatcher.h"

@interface KindOfClassMatcherTests : SenTestCase
@end

@implementation KindOfClassMatcherTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

-(void) testMatchesAViewOfTheTargetClass {
    id kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    expect([kindOfUIButtonClassMatcher matchesView:button]).toBeTruthy();
}

- (void)testMismatchesAViewOfANonTargetClass {
    id kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIView* view = [[UIView alloc] initWithFrame:frame];
    expect([kindOfUIButtonClassMatcher matchesView:view]).toBeFalsy();
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id kindOfUIViewClassMatcher = [KindOfClassMatcher forClass:[UIView class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    expect([kindOfUIViewClassMatcher matchesView:button]).toBeTruthy();
}

@end
