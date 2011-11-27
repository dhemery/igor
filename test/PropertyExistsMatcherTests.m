//
//  AnAttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyExistsMatcher.h"

@interface PropertyExistsMatcherTests : SenTestCase
@end

@implementation PropertyExistsMatcherTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

-(void) testMatchesAViewThatHasTheTargetProperty {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    id matcher = [PropertyExistsMatcher forProperty:@"accessibilityHint"];
    expect([matcher matchesView:view]).toBeTruthy();
}

-(void) testMismatchesAViewThatDoesNotHaveTheTargetProperty {
    UIView* view = [[UIButton alloc] initWithFrame:frame];
    id matcher = [PropertyExistsMatcher forProperty:@"aNonExistentProperty"];
    expect([matcher matchesView:view]).toBeFalsy();
}

@end
