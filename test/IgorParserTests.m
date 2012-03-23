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
    IgorParser *parser;
}

- (void)setUp {
    parser = [IgorParser new];
}

- (void)testParsesAsteriskAsKindOfClassMatcherForUIViewClass {
    ClassMatcher *matcher = ((NodeMatcher *) [parser parse:@"*"]).classMatcher;
    expect(matcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UIView class]);
}

- (void)testParsesNameAsMemberOfClassMatcher {
    NodeMatcher *matcher = (NodeMatcher *) [parser parse:@"UIButton"];
    expect(matcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(matcher.classMatcher.matchClass).toEqual([UIButton class]);
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    NodeMatcher *matcher = (NodeMatcher *) [parser parse:@"UILabel*"];
    expect(matcher.classMatcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.classMatcher.matchClass).toEqual([UILabel class]);
}

- (void)testParsesNodeMatcherWithPredicateMatcher {
    NSString *predicateExpression = [[NSPredicate predicateWithFormat:@"myPropertyName='somevalue'"] predicateFormat];
    NodeMatcher *matcher = (NodeMatcher *) [parser parse:@"*[myPropertyName='somevalue']"];

    expect(matcher.classMatcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.classMatcher.matchClass).toEqual([UIView class]);

    expect(matcher.predicateMatcher).toBeInstanceOf([PredicateMatcher class]);
    expect(matcher.predicateMatcher.matchExpression).toEqual(predicateExpression);
}

- (void)testParsesDescendantCombinatorMatcher {
    DescendantCombinatorMatcher *matcher = (DescendantCombinatorMatcher *) [parser parse:@"UIButton UILabel"];
    expect(matcher).toBeInstanceOf([DescendantCombinatorMatcher class]);

    NodeMatcher *ancestorMatcher = matcher.ancestorMatcher;
    expect(ancestorMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorMatcher.classMatcher.matchClass).toEqual([UIButton class]);

    NodeMatcher *descendantMatcher = matcher.descendantMatcher;
    expect(descendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(descendantMatcher.classMatcher.matchClass).toEqual([UILabel class]);
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    DescendantCombinatorMatcher *matcher = (DescendantCombinatorMatcher *) [parser parse:@"UIButton UILabel UIView UITextField"];
    expect(matcher).toBeInstanceOf([DescendantCombinatorMatcher class]);

    NodeMatcher *descendantMatcher = matcher.descendantMatcher;
    expect(descendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(descendantMatcher.classMatcher.matchClass).toEqual([UITextField class]);

    DescendantCombinatorMatcher *ancestorMatcher = (DescendantCombinatorMatcher *) matcher.ancestorMatcher;
    expect(ancestorMatcher).toBeInstanceOf([DescendantCombinatorMatcher class]);

    NodeMatcher *ancestorDescendantMatcher = ancestorMatcher.descendantMatcher;
    expect(ancestorDescendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorDescendantMatcher.classMatcher.matchClass).toEqual([UIView class]);

    DescendantCombinatorMatcher *ancestorAncestorMatcher = (DescendantCombinatorMatcher *) ancestorMatcher.ancestorMatcher;
    expect(ancestorAncestorMatcher).toBeInstanceOf([DescendantCombinatorMatcher class]);

    NodeMatcher *ancestorAncestorDescendantMatcher = ancestorAncestorMatcher.descendantMatcher;
    expect(ancestorAncestorDescendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorAncestorDescendantMatcher.classMatcher.matchClass).toEqual([UILabel class]);

    NodeMatcher *ancestorAncestorAncestorMatcher = (NodeMatcher *) ancestorAncestorMatcher.ancestorMatcher;
    expect(ancestorAncestorAncestorMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorAncestorAncestorMatcher.classMatcher.matchClass).toEqual([UIButton class]);
}
@end

