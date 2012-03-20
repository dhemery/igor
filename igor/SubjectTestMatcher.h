//
//  SubjectTestMatcher.h
//  igor
//
//  Created by Dale Emery on 3/19/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "Igor.h"
#import "Matcher.h"

@interface SubjectTestMatcher : NSObject<Matcher>
@property(retain,readonly) id<Matcher> subject;
@property(retain,readonly) id<Matcher> test;
@property(retain,readonly) Igor* igor;

+(id)forSubject:(id<Matcher>)subject test:(id<Matcher>)test igor:(Igor*)igor;

@end
