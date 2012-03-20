//
//  TreeWalker.h
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@interface TreeWalker : NSObject
- (void)findViewsThatMatch:(id<Matcher>)matcher fromRoot:(UIView *)root intoSet:(NSMutableSet*)matchingViews;
@end
