//
//  AnIgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "UniversalSelector.h"
#import "ClassEqualsSelector.h"
#import "KindOfClassSelector.h"

@interface AnIgorParser : SenTestCase
@end

@implementation AnIgorParser {
    IgorParser* parser;
}

-(void) setUp {
    parser = [IgorParser new];
}

-(void) testParsesAnAsteristAsAUniversalSelector {
    id<Selector> selector = [parser parse:@"*"];
    assertThat(selector, instanceOf([UniversalSelector class]));
}

-(void) testParsesANameAsAClassEqualsSelector {
    id<Selector> selector = [parser parse:@"UIButton"];
    assertThat(selector, instanceOf([ClassEqualsSelector class]));
    ClassEqualsSelector* classEqualsSelector = (ClassEqualsSelector*)selector;
    assertThat(classEqualsSelector.targetClass, equalTo([UIButton class]));
}

-(void) testParsesANameAsteriskAsAKindOfClassSelector {
    id<Selector> selector = [parser parse:@"UILabel*"];
    assertThat(selector, instanceOf([KindOfClassSelector class]));           
    KindOfClassSelector* kindOfClassSelector = (KindOfClassSelector*)selector;
    assertThat(kindOfClassSelector.targetClass, equalTo([UILabel class]));
}
@end
