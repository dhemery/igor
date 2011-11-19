//
//  AnIgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "ClassEqualsSelector.h"
#import "KindOfClassSelector.h"
#import "CompoundSelector.h"
#import "PropertyExistsSelector.h"

@interface AnIgorParser : SenTestCase
@end

@implementation AnIgorParser {
    IgorParser* parser;
}

-(void) setUp {
    parser = [IgorParser new];
}

-(void) testParsesAsteriskAsKindOfClassSelectorForUIViewClass {
    id<Selector> selector = [parser parse:@"*"];
    assertThat(selector, instanceOf([KindOfClassSelector class]));
    KindOfClassSelector* kindOfClassSelector = (KindOfClassSelector*)selector;
    assertThat(kindOfClassSelector.targetClass, equalTo([UIView class]));
}

-(void) testParsesNameAsClassEqualsSelector {
    id<Selector> selector = [parser parse:@"UIButton"];
    assertThat(selector, instanceOf([ClassEqualsSelector class]));
    ClassEqualsSelector* classEqualsSelector = (ClassEqualsSelector*)selector;
    assertThat(classEqualsSelector.targetClass, equalTo([UIButton class]));
}

-(void) testParsesNameAsteriskAsKindOfClassSelector {
    id<Selector> selector = [parser parse:@"UILabel*"];
    assertThat(selector, instanceOf([KindOfClassSelector class]));           
    KindOfClassSelector* kindOfClassSelector = (KindOfClassSelector*)selector;
    assertThat(kindOfClassSelector.targetClass, equalTo([UILabel class]));
}

-(void) testParsesCompoundSelectorWithOneAttributeSelector {
    id<Selector> selector = [parser parse:@"*[myPropertyName]"];

    assertThat(selector, instanceOf([CompoundSelector class]));
    CompoundSelector* compoundSelector = (CompoundSelector*)selector;

    NSArray* simpleSelectors = compoundSelector.simpleSelectors;
    assertThat(compoundSelector.simpleSelectors, hasCountOf(2));

    ClassSelector* classSelector = [simpleSelectors objectAtIndex:0];
    assertThat(classSelector, instanceOf([KindOfClassSelector class]));
    assertThat([classSelector targetClass], equalTo([UIView class]));

    PropertyExistsSelector* attributeSelector = [simpleSelectors objectAtIndex:1];
    assertThat(attributeSelector, instanceOf([PropertyExistsSelector class]));
    assertThat(attributeSelector.propertyName, equalTo(@"myPropertyName"));
}

@end

