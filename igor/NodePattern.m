//
//  NodePattern.m
//  igor
//
//  Created by Dale Emery on 3/20/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "ClassPattern.h"
#import "NodeMatcher.h"
#import "NodePattern.h"
#import "PredicatePattern.h"

@implementation NodePattern

-(id<Matcher>) parse:(NSScanner*)scanner {
    id classMatcher = [[ClassPattern new] parse:scanner];
    id predicateMatcher = [[PredicatePattern new] parse:scanner];
    if(predicateMatcher) {
        return [NodeMatcher withClassMatcher:classMatcher predicateMatcher:predicateMatcher];
    }
    return classMatcher;
}

@end
