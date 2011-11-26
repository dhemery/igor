//
//  AClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"
#import "MemberOfClassMatcher.h"

@interface MemberOfClassMatcherTests : SenTestCase
@end

@implementation MemberOfClassMatcherTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

- (void)testMatchesAViewOfTheTargetClass {
    id memberOfUIButtonClassMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    expect([memberOfUIButtonClassMatcher matchesView:button]).toBeTruthy();
}

- (void)testMismatchesAViewOfANonTargetClass {
    id memberOfUIButtonClassMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIView* view = [[UIView alloc] initWithFrame:frame];
    expect([memberOfUIButtonClassMatcher matchesView:view]).toBeFalsy();
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id memberOfUIViewClassMatcher = [MemberOfClassMatcher forClass:[UIView class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    expect([memberOfUIViewClassMatcher matchesView:button]).toBeFalsy();
}

@end
