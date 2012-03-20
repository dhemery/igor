//
//  SubtreePatternTests.m
//  igor
//
//  Created by Dale Emery on 3/10/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"

@interface SubjectPatternTests : SenTestCase
@end

@implementation SubjectPatternTests {
    CGRect frame;
    Igor* igor;
    UIView* root;
    UIView* middle;
    UIView* leaf;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
    igor = [Igor new];
    root = [self buttonWithAccessibilityHint:@"root"];
    middle = [self buttonWithAccessibilityHint:@"middle"];
    leaf = [self buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

- (id) buttonWithAccessibilityHint:(NSString*)hint {
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    button.accessibilityHint = hint;
    return button;
}

-(void) testAllowsSubjectMarker {
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"*! *" fromRoot:root];
    expect(matchingViews).toContain(root);
    expect(matchingViews).toContain(middle);
    expect(matchingViews).Not.toContain(leaf);
}

-(void) testMatchesMarkedSubject {
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"*! [accessibilityHint='middle']" fromRoot:root];
    expect(matchingViews).toContain(root);
    expect(matchingViews).Not.toContain(middle);
    expect(matchingViews).Not.toContain(leaf);
}

@end
