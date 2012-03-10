//
//  PredicateMatcher.m
//  igor
//
//  Created by Dale Emery on 11/30/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PredicateMatcher.h"

@implementation PredicateMatcher {
    NSPredicate* predicate;
}

+(id) forPredicateExpression:(NSString*)expression {
    return [[PredicateMatcher alloc] initWithPredicateExpression:expression];
}

-(id) initWithPredicateExpression:(NSString*)expression {
    if(self = [super init]) {        
        predicate = [NSPredicate predicateWithFormat:expression];
    }
    return self;
}

-(NSString*) matchExpression {
    return [predicate predicateFormat];
}

-(BOOL) matchesView:(UIView *)view {
    @try {
        return [predicate evaluateWithObject:view];
    }
    @catch (NSException* e) {
        return NO;
    }
}

-(NSString*) description {
    return [NSString stringWithFormat:@"[PredicateMatcher:[predicate:%@]]", predicate];
}

@end
