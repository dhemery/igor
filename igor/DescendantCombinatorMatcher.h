//
//  CombinatorMatcher.h
//  igor
//
//  Created by Dale Emery on 3/8/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@interface DescendantCombinatorMatcher : NSObject<Matcher>

@property(retain) id<Matcher> ancestorMatcher;
@property(retain) id<Matcher> descendantMatcher;

+(id) forAncestorMatcher:(id<Matcher>) ancestorMatcher descendantMatcher:(id<Matcher>) descendantMatcher;
-(id) initWithAncestorMatcher:(id<Matcher>) ancestorMatcher descendantMatcher:(id<Matcher>) descendantMatcher;

@end
