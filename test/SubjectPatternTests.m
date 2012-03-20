//
//  SubtreePatternTests.m
//  igor
//
//  Created by Dale Emery on 3/10/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"
#import "ViewFactory.h"

@interface SubjectPatternTests : SenTestCase
@end

@implementation SubjectPatternTests {
    Igor* igor;
    UIView* root;
    UIView* middle;
    UIView* leaf;
}

-(void) setUp {
    igor = [Igor new];
    root = [ViewFactory buttonWithAccessibilityHint:@"root"];
    middle = [ViewFactory buttonWithAccessibilityHint:@"middle"];
    leaf = [ViewFactory buttonWithAccessibilityHint:@"leaf"];
    [root addSubview:middle];
    [middle addSubview:leaf];
}

-(void) testMatchesIfTheViewMatchesTheSubjectPatternAndHasASubviewThatMatchesTheSubtreePattern {
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"*! [accessibilityHint='middle']" fromRoot:root];
    expect(matchingViews).toContain(root);
    expect(matchingViews).Not.toContain(middle);
    expect(matchingViews).Not.toContain(leaf);
}

-(void) testMatchesEachViewThatMatchesTheSubjectPatternAndHasASubviewThatMatchesTheSubtreePattern {
    NSArray* matchingViews = [igor findViewsThatMatchPattern:@"*! [accessibilityHint='leaf']" fromRoot:root];
    expect(matchingViews).toContain(root);
    expect(matchingViews).toContain(middle);
    expect(matchingViews).Not.toContain(leaf);
}

@end
