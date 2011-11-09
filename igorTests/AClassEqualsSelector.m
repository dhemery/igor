//
//  AClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/8/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "AClassEqualsSelector.h"
#import "Igor.h"

@implementation AClassEqualsSelector {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}


- (void) testAUniversalClassSelectorSelectsTheRootViewAndAllSubviews {
    UIView *root = [[UIView alloc] initWithFrame:frame];
    UIView *button = [[UIButton alloc] initWithFrame: frame];
    UIView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [root addSubview:button];
    [button addSubview:imageView];
    
    Igor *igor = [Igor igorFor:@"UIButton"];
    NSMutableSet *selectedViews = [igor selectViewsFromRoot:root];
    
    STAssertNil([selectedViews member:root], @"root");
    STAssertNotNil([selectedViews member:button], @"button");
    STAssertNil([selectedViews member:imageView], @"imageView");

}
@end
