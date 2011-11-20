//
//  AClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Selector.h"
#import "ClassEqualsSelector.h"

@interface ClassEqualsSelectorTests : SenTestCase
@end

@implementation ClassEqualsSelectorTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

- (void)testMatchesAViewOfTheTargetClass {
    id<Selector> buttonSelector = [[ClassEqualsSelector alloc] initWithTargetClass:[UIButton class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    STAssertTrue([buttonSelector matchesView:button], @"Matches the target class");
}

- (void)testMismatchesAViewOfANonTargetClass {
    id<Selector> buttonSelector = [[ClassEqualsSelector alloc] initWithTargetClass:[UIButton class]];
    UIView* view = [[UIView alloc] initWithFrame:frame];
    STAssertFalse([buttonSelector matchesView:view], @"Mismatches a non-target class");
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id<Selector> viewSelector = [[ClassEqualsSelector alloc] initWithTargetClass:[UIView class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    STAssertFalse([viewSelector matchesView:button], @"Mismatches a derived class");
}

@end
