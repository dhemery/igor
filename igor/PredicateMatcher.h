//
//  PredicateMatcher.h
//  igor
//
//  Created by Dale Emery on 11/30/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@interface PredicateMatcher : NSObject<Matcher>

@property(readonly,retain) NSString* matchExpression;

+(id) forPredicateExpression:(NSString*)expression;
-(id) initWithPredicateExpression:(NSString*)expression;

@end
