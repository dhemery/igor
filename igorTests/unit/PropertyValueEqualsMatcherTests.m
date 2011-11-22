//
//  AnAttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyValueEqualsMatcher.h"

@interface PropertyValueEqualsMatcherTests : SenTestCase
@end

@implementation PropertyValueEqualsMatcherTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

//-(void) testMatchesAViewThatHasTheTargetProperty {
//    UIView* view = [[UIView alloc] initWithFrame:frame];
//    id matcher = [PropertyValueEqualsMatcher forProperty:@"accessibilityHint" value:nil];
//    STAssertTrue([matcher matchesView:view], @"Matches a view that has the property");
//}
//
//-(void) testMismatchesAViewThatDoesNotHaveTheTargetProperty {
//    UIView* view = [[UIView alloc] initWithFrame:frame];
//    id matcher = [PropertyValueEqualsMatcher forProperty:@"aNonExistentProperty" value:nil];
//    STAssertFalse([matcher matchesView:view], @"Matches a view that does not have the property");
//}
@end
