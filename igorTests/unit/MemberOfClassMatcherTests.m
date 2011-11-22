//
//  AClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
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
    id<Matcher> matcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    STAssertTrue([matcher matchesView:button], @"Matches the target class");
}

- (void)testMismatchesAViewOfANonTargetClass {
    id<Matcher> matcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIView* view = [[UIView alloc] initWithFrame:frame];
    STAssertFalse([matcher matchesView:view], @"Mismatches a non-target class");
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id<Matcher> matcher = [MemberOfClassMatcher forClass:[UIView class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    STAssertFalse([matcher matchesView:button], @"Mismatches a derived class");
}

@end
