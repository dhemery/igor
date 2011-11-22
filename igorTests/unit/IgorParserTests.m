//
//  AnIgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IgorParser.h"
#import "ClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "KindOfClassMatcher.h"
#import "CompoundMatcher.h"
#import "PropertyExistsMatcher.h"

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
    assertThat(matcher, instanceOf([KindOfClassMatcher class]));
    assertThat(matcher.matchClass, equalTo([UIView class]));
}

-(void) testParsesNameAsMemberOfClassMatcher {
    id<ClassMatcher> matcher = [parser parse:@"UIButton"];
    assertThat(matcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(matcher.matchClass, equalTo([UIButton class]));
}

-(void) testParsesNameAsteriskAsKindOfClassMatcher {
    id<ClassMatcher> matcher = [parser parse:@"UILabel*"];
    assertThat(matcher, instanceOf([KindOfClassMatcher class]));           
    assertThat(matcher.matchClass, equalTo([UILabel class]));
}

-(void) testParsesCompoundMatcherWithOneAttributeMatcher {
    id<Matcher> matcher = [parser parse:@"*[myPropertyName]"];

    assertThat(matcher, instanceOf([CompoundMatcher class]));
    CompoundMatcher* compoundMatcher = (CompoundMatcher*)matcher;

    NSArray* simpleMatchers = compoundMatcher.simpleMatchers;
    assertThat(compoundMatcher.simpleMatchers, hasCountOf(2));

    id<ClassMatcher> classMatcher = [simpleMatchers objectAtIndex:0];
    assertThat(classMatcher, instanceOf([KindOfClassMatcher class]));
    assertThat(classMatcher.matchClass, equalTo([UIView class]));

    id<PropertyMatcher> propertyMatcher = [simpleMatchers objectAtIndex:1];
    assertThat(propertyMatcher, instanceOf([PropertyExistsMatcher class]));
    assertThat(propertyMatcher.matchProperty, equalTo(@"myPropertyName"));
}

@end

