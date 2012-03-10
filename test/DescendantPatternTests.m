//
//  DescendantPatternTests.m
//  igor
//
//  Created by Dale Emery on 3/8/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"

@interface DescendantPatternTests : SenTestCase
@end

@implementation DescendantPatternTests {
CGRect frame;
Igor* igor;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    igor = [Igor new];
}

- (id) buttonWithAccessibilityHint:(NSString*)hint {
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    button.accessibilityHint = hint;
    return button;
}

-(void) testFindsMatchingChildren {
    UIView* top = [self buttonWithAccessibilityHint:@"top"];
    UIView* matchingSubview = [self buttonWithAccessibilityHint:@"matches"];
    UIView* nonMatchingSubview = [self buttonWithAccessibilityHint:@"does not match"];
    [top addSubview:matchingSubview];
    [top addSubview:nonMatchingSubview];
    
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews).toContain(matchingSubview);
    expect(matchingViews).Not.toContain(nonMatchingSubview);
}

-(void) testFindsMatchingDescendants {
    UIView* top = [self buttonWithAccessibilityHint:@"top"];
    UIView* interveningView = [self buttonWithAccessibilityHint:@"does not match"];
    UIView* matchingDescendant = [self buttonWithAccessibilityHint:@"matches"];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];
    
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews).toContain(matchingDescendant);
    expect(matchingViews).Not.toContain(interveningView);
}

-(void) testFindsAcrossUniversalClassMatcher {
    UIView* top = [self buttonWithAccessibilityHint:@"top"];
    UIView* interveningView = [self buttonWithAccessibilityHint:@"does not match"];
    UIView* matchingDescendant = [self buttonWithAccessibilityHint:@"matches"];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];
    
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] * [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews).toContain(matchingDescendant);
    expect(matchingViews).Not.toContain(interveningView);
}

-(void) testRequiresMatchForEachUniversalClassMatcher {
    UIView* top = [self buttonWithAccessibilityHint:@"top"];
    UIView* interveningView = [self buttonWithAccessibilityHint:@"does not match"];
    UIView* matchingDescendant = [self buttonWithAccessibilityHint:@"matches"];
    [top addSubview:interveningView];
    [interveningView addSubview:matchingDescendant];
    
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"[accessibilityHint='top'] * * [accessibilityHint='matches']" fromRoot:top];
    expect(matchingViews.count).toEqual(0);
}

@end
