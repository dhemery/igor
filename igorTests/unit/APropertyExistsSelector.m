//
//  AnAttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Selector.h"
#import "PropertyExistsSelector.h"

@interface APropertyExistsSelector : SenTestCase
@end

@implementation APropertyExistsSelector {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

-(void) testMatchesAViewThatHasTheTargetProperty {
    UIView* view = [[UIView alloc] initWithFrame:frame];
    id<Selector> selector = [PropertyExistsSelector selectorWithPropertyName:@"accessibilityHint"];
    STAssertTrue([selector matchesView:view], @"Matches a view that has the property");
}

-(void) testMismatchesAViewThatDoesNotHaveTheTargetProperty {
    UIView* view = [[UIView alloc] initWithFrame:frame];
    id<Selector> selector = [PropertyExistsSelector selectorWithPropertyName:@"aNonExistentProperty"];
    STAssertFalse([selector matchesView:view], @"Matches a view that does not have the property");
}
@end
