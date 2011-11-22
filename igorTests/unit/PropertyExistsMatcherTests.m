//
//  AnAttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matcher.h"
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
    UIView* view = [[UIView alloc] initWithFrame:frame];
    id<Matcher> matcher = [PropertyExistsMatcher forProperty:@"accessibilityHint"];
    STAssertTrue([matcher matchesView:view], @"Matches a view that has the property");
}

-(void) testMismatchesAViewThatDoesNotHaveTheTargetProperty {
    UIView* view = [[UIView alloc] initWithFrame:frame];
    id<Matcher> matcher = [PropertyExistsMatcher forProperty:@"aNonExistentProperty"];
    STAssertFalse([matcher matchesView:view], @"Matches a view that does not have the property");
}
@end
