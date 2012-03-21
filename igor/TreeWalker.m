//
//  TreeWalker.m
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "TreeWalker.h"

@implementation TreeWalker

+(void) walkTree:(UIView*)root withVisitor:(void(^)(UIView*))visit {
    visit(root);
    for(id subview in [root subviews]) {
        [self walkTree:subview withVisitor:visit];
    }
}

@end
