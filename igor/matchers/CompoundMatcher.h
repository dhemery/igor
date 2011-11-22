//
//  CompoundSelector.h
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "matcher.h"

@interface CompoundMatcher : NSObject<Matcher>

@property(retain) NSMutableArray* simpleMatchers;

-(void) addMatcher:(id<Matcher>)matcher;

@end
