//
//  AnAttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyValueEqualsMatcher.h"

@interface MyUIButton : UIButton
@property(retain) NSString* thePropertyWithTheDefaultGetter;
@property(retain,getter=customGetter) NSString* thePropertyWithTheCustomGetter;
@end

@implementation MyUIButton
@synthesize thePropertyWithTheDefaultGetter, thePropertyWithTheCustomGetter;
@end


@interface PropertyValueEqualsMatcherTests : SenTestCase
@end

@implementation PropertyValueEqualsMatcherTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

-(void) testMatchesAViewThatHasTheTargetPropertyValue {
    id view = [[MyUIButton alloc] initWithFrame:frame];
    [view setThePropertyWithTheDefaultGetter:@"the target value"];
    id matcher = [PropertyValueEqualsMatcher forProperty:@"thePropertyWithTheDefaultGetter" value:@"the target value"];
    STAssertTrue([matcher matchesView:view], @"");
}

-(void) testMismatchesAViewThatDoesNotHaveTheTargetProperty {
    id view = [[MyUIButton alloc] initWithFrame:frame];
    id matcher = [PropertyValueEqualsMatcher forProperty:@"aNonExistentProperty" value:@"doesn't matter"];
    STAssertFalse([matcher matchesView:view], @"");
}

-(void) testMismatchesAViewThatDoesNotHaveTheTargetPropertyValue {
    id view = [[MyUIButton alloc] initWithFrame:frame];
    [view setThePropertyWithTheDefaultGetter:@"NOT the target value"];
    id matcher = [PropertyValueEqualsMatcher forProperty:@"thePropertyWithTheDefaultGetter" value:@"the target value"];
    STAssertFalse([matcher matchesView:view], @"");
}

-(void) testMatchesUsingACustomGetterIfOneIsDefined {
    id view = [[MyUIButton alloc] initWithFrame:frame];
    [view setThePropertyWithTheCustomGetter:@"the target value"];
    id matcher = [PropertyValueEqualsMatcher forProperty:@"thePropertyWithTheCustomGetter" value:@"the target value"];
    STAssertTrue([matcher matchesView:view], @"");
}
@end
