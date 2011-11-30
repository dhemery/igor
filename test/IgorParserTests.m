//
//  AnIgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "ClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "KindOfClassMatcher.h"
#import "CompoundMatcher.h"
#import "PredicateMatcher.h"

@interface IgorParserTests : SenTestCase
@end

@implementation IgorParserTests {
    IgorParser* parser;
}

-(void) setUp {
    parser = [IgorParser new];
}

-(void) testParsesAsteriskAsKindOfClassMatcherForUIViewClass {
    id<ClassMatcher> matcher = [parser parse:@"*"];
    expect(matcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UIView class]);
}

-(void) testParsesNameAsMemberOfClassMatcher {
    id<ClassMatcher> matcher = [parser parse:@"UIButton"];
    expect(matcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UIButton class]);
}

-(void) testParsesNameAsteriskAsKindOfClassMatcher {
    id<ClassMatcher> matcher = [parser parse:@"UILabel*"];
    expect(matcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UILabel class]);
}

-(void) testParsesCompoundMatcherWithOnePredicateMatcher {
    id<Matcher> matcher = [parser parse:@"*[myPropertyName='somevalue']"];

    expect(matcher).toBeInstanceOf([CompoundMatcher class]);
    CompoundMatcher* compoundMatcher = (CompoundMatcher*)matcher;

    NSArray* simpleMatchers = compoundMatcher.simpleMatchers;
    expect([compoundMatcher.simpleMatchers count]).toEqual(2);

    id<ClassMatcher> classMatcher = [simpleMatchers objectAtIndex:0];
    expect(classMatcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(classMatcher.matchClass).toEqual([UIView class]);

    id predicateMatcher = [simpleMatchers objectAtIndex:1];
    expect(predicateMatcher).toBeInstanceOf([PredicateMatcher class]);
//    expect(propertyMatcher.matchProperty).toEqual(@"myPropertyName");
}

@end

