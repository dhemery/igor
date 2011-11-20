//
//  AKindOfClassSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "KindOfClassSelector.h"

@interface AKindOfClassSelector : SenTestCase
@end

@implementation AKindOfClassSelector {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

-(void) testMatchesAViewOfTheTargetClass {
    id<Selector> buttonSelector = [[KindOfClassSelector alloc] initWithTargetClass:[UIButton class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    STAssertTrue([buttonSelector matchesView:button], @"Matches the target class");
}

- (void)testMismatchesAViewOfANonTargetClass {
    id<Selector> buttonSelector = [[KindOfClassSelector alloc] initWithTargetClass:[UIButton class]];
    UIView* view = [[UIView alloc] initWithFrame:frame];
    STAssertFalse([buttonSelector matchesView:view], @"Mismatches a non-target class");
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id<Selector> viewSelector = [[KindOfClassSelector alloc] initWithTargetClass:[UIView class]];
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    STAssertTrue([viewSelector matchesView:button], @"Matches a derived class");
}

@end
