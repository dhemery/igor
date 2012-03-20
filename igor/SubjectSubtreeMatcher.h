//
//  SubjectTestMatcher.h
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@interface SubjectSubtreeMatcher : NSObject<Matcher>

@property(retain,readonly) id<Matcher> subjectMatcher;
@property(retain,readonly) id<Matcher> subtreeMatcher;

+(id<Matcher>) withSubjectMatcher:(id<Matcher>)subjectMatcher subtreeMatcher:(id<Matcher>)subtreeMatcher;

@end
