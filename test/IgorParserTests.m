
#import "IgorParser.h"
#import "ClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "KindOfClassMatcher.h"
#import "NodeMatcher.h"
#import "PredicateMatcher.h"
#import "DescendantCombinatorMatcher.h"

@interface IgorParserTests : SenTestCase
@end

@implementation IgorParserTests {
    IgorParser* parser;
}

-(void) setUp {
    parser = [IgorParser new];
}

-(void) testParsesAsteriskAsKindOfClassMatcherForUIViewClass {
    id<ClassMatcher> matcher = (id)[parser parse:@"*"];
    expect(matcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UIView class]);
}

-(void) testParsesNameAsMemberOfClassMatcher {
    id<ClassMatcher> matcher = (id)[parser parse:@"UIButton"];
    expect(matcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UIButton class]);
}

-(void) testParsesNameAsteriskAsKindOfClassMatcher {
    id<ClassMatcher> matcher = (id)[parser parse:@"UILabel*"];
    expect(matcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UILabel class]);
}

-(void) testParsesCompoundMatcherWithOnePredicateMatcher {
    id<Matcher> matcher = [parser parse:@"*[myPropertyName='somevalue']"];

    expect(matcher).toBeInstanceOf([NodeMatcher class]);
    NodeMatcher* compoundMatcher = (NodeMatcher*)matcher;

    NSArray* simpleMatchers = compoundMatcher.simpleMatchers;
    expect([compoundMatcher.simpleMatchers count]).toEqual(2);

    id<ClassMatcher> classMatcher = [simpleMatchers objectAtIndex:0];
    expect(classMatcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(classMatcher.matchClass).toEqual([UIView class]);

    id predicateMatcher = [simpleMatchers objectAtIndex:1];
    expect(predicateMatcher).toBeInstanceOf([PredicateMatcher class]);
}

-(void) testParsesDescendantCombinatorMatcher {
    id<Matcher> matcher = [parser parse:@"UIButton UILabel"];
    
    expect(matcher).toBeInstanceOf([DescendantCombinatorMatcher class]);
    DescendantCombinatorMatcher* descendantCombinatorMatcher = (DescendantCombinatorMatcher*)matcher;
    expect(descendantCombinatorMatcher.ancestorMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    MemberOfClassMatcher* ancestorMatcher = (MemberOfClassMatcher*)descendantCombinatorMatcher.ancestorMatcher;
    expect(ancestorMatcher.matchClass).toEqual([UIButton class]);
    expect(descendantCombinatorMatcher.descendantMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    MemberOfClassMatcher* descendantMatcher = (MemberOfClassMatcher*)descendantCombinatorMatcher.descendantMatcher;
    expect(descendantMatcher.matchClass).toEqual([UILabel class]);
}

-(void) testParsesMultipleDescendantCombinatorMatchers {
    id<Matcher> matcher = [parser parse:@"UIButton UILabel UIView UITextField"];

    expect(matcher).toBeInstanceOf([DescendantCombinatorMatcher class]);
    DescendantCombinatorMatcher* descendantCombinatorMatcher = (DescendantCombinatorMatcher*)matcher;

    expect(descendantCombinatorMatcher.descendantMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    MemberOfClassMatcher* descendantMatcher = (MemberOfClassMatcher*)descendantCombinatorMatcher.descendantMatcher;
    expect(descendantMatcher.matchClass).toEqual([UITextField class]);

    expect(descendantCombinatorMatcher.ancestorMatcher).toBeInstanceOf([DescendantCombinatorMatcher class]);
    DescendantCombinatorMatcher* ancestorMatcher = (DescendantCombinatorMatcher*)descendantCombinatorMatcher.ancestorMatcher;

    expect(ancestorMatcher.descendantMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    MemberOfClassMatcher* ancestorDescendantMatcher = (MemberOfClassMatcher*)ancestorMatcher.descendantMatcher;
    expect(ancestorDescendantMatcher.matchClass).toEqual([UIView class]);
    
    expect(ancestorMatcher.ancestorMatcher).toBeInstanceOf([DescendantCombinatorMatcher class]);
    DescendantCombinatorMatcher* ancestorAncestorMatcher = (DescendantCombinatorMatcher*)ancestorMatcher.ancestorMatcher;

    expect(ancestorAncestorMatcher.descendantMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    MemberOfClassMatcher* ancestorAncestorDescendantMatcher = (MemberOfClassMatcher*)ancestorAncestorMatcher.descendantMatcher;
    expect(ancestorAncestorDescendantMatcher.matchClass).toEqual([UILabel class]);
    
    expect(ancestorAncestorMatcher.ancestorMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    MemberOfClassMatcher* ancestorAncestorAncestorMatcher = (MemberOfClassMatcher*)ancestorAncestorMatcher.ancestorMatcher;
    expect(ancestorAncestorAncestorMatcher.matchClass).toEqual([UIButton class]);
}
@end

