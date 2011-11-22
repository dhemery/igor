//
//  AKindOfClassSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
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
    STAssertTrue([kindOfUIButtonClassMatcher matchesView:button], @"Matches the target class");
}

- (void)testMismatchesAViewOfANonTargetClass {
    id kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIView* view = [[UIView alloc] initWithFrame:frame];
    STAssertFalse([kindOfUIButtonClassMatcher matchesView:view], @"Mismatches a non-target class");
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id kindOfUIViewClassMatcher = [KindOfClassMatcher forClass:[UIView class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    STAssertTrue([kindOfUIViewClassMatcher matchesView:button], @"Matches a derived class");
}

@end
