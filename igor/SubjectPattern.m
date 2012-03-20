//
//  SubjectPattern.m
//  igor
//
//  Created by Dale Emery on 3/20/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "DescendantCombinatorMatcher.h"
#import "Matcher.h"
#import "NodePattern.h"
#import "SubjectPattern.h"

@implementation SubjectPattern

-(id<Matcher>) parse:(NSScanner *)scanner {
    id<Matcher> matcher = [[NodePattern alloc] parse:scanner];
    while([scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil]) {
        id<Matcher> descendantMatcher = [[NodePattern alloc] parse:scanner];
        matcher = [DescendantCombinatorMatcher withAncestorMatcher:matcher descendantMatcher:descendantMatcher];
    }
    return matcher;
}

@end
