//
//  AnIgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IgorParser.h"
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
    id<Matcher> matcher = [parser parse:@"*"];
    assertThat(matcher, instanceOf([KindOfClassMatcher class]));
    KindOfClassMatcher* kindOfClassMatcher = (KindOfClassMatcher*)matcher;
    assertThat(kindOfClassMatcher.targetClass, equalTo([UIView class]));
}

-(void) testParsesNameAsMemberOfClassMatcher {
    id<Matcher> matcher = [parser parse:@"UIButton"];
    assertThat(matcher, instanceOf([MemberOfClassMatcher class]));
    MemberOfClassMatcher* memberOfClassMatcher = (MemberOfClassMatcher*)matcher;
    assertThat(memberOfClassMatcher.targetClass, equalTo([UIButton class]));
}

-(void) testParsesNameAsteriskAsKindOfClassMatcher {
    id<Matcher> matcher = [parser parse:@"UILabel*"];
    assertThat(matcher, instanceOf([KindOfClassMatcher class]));           
    KindOfClassMatcher* kindOfClassMatcher = (KindOfClassMatcher*)matcher;
    assertThat(kindOfClassMatcher.targetClass, equalTo([UILabel class]));
}

-(void) testParsesCompoundMatcherWithOneAttributeMatcher {
    id<Matcher> matcher = [parser parse:@"*[myPropertyName]"];

    assertThat(matcher, instanceOf([CompoundMatcher class]));
    CompoundMatcher* compoundMatcher = (CompoundMatcher*)matcher;

    NSArray* simpleMatchers = compoundMatcher.simpleMatchers;
    assertThat(compoundMatcher.simpleMatchers, hasCountOf(2));

    ClassMatcher* classMatcher = [simpleMatchers objectAtIndex:0];
    assertThat(classMatcher, instanceOf([KindOfClassMatcher class]));
    assertThat([classMatcher targetClass], equalTo([UIView class]));

    PropertyExistsMatcher* propertyMatcher = [simpleMatchers objectAtIndex:1];
    assertThat(propertyMatcher, instanceOf([PropertyExistsMatcher class]));
    assertThat(propertyMatcher.propertyName, equalTo(@"myPropertyName"));
}

@end

