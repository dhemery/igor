#import "IgorPattern.h"
#import "ClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "KindOfClassMatcher.h"
#import "NodeMatcher.h"
#import "PredicateMatcher.h"
#import "SubjectAndAncestorMatcher.h"

@interface IgorParserTests : SenTestCase
@end

@implementation IgorParserTests

- (void)testParsesAsteriskAsKindOfClassMatcherForUIViewClass {
    ClassMatcher *matcher = ((NodeMatcher *) [[IgorPattern forPattern:@"*"] parse]).classMatcher;
    expect(matcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.matchClass).toEqual([UIView class]);
}

- (void)testParsesNameAsMemberOfClassMatcher {
    NodeMatcher *matcher = (NodeMatcher *) [[IgorPattern forPattern:@"UIButton"] parse];
    expect(matcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(matcher.classMatcher.matchClass).toEqual([UIButton class]);
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    NodeMatcher *matcher = (NodeMatcher *) [[IgorPattern forPattern:@"UILabel*"] parse];
    expect(matcher.classMatcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.classMatcher.matchClass).toEqual([UILabel class]);
}

- (void)testParsesNodeMatcherWithPredicateMatcher {
    NSString *predicateExpression = [[NSPredicate predicateWithFormat:@"myPropertyName='somevalue'"] predicateFormat];
    NodeMatcher *matcher = (NodeMatcher *) [[IgorPattern forPattern:@"*[myPropertyName='somevalue']"] parse];

    expect(matcher.classMatcher).toBeInstanceOf([KindOfClassMatcher class]);
    expect(matcher.classMatcher.matchClass).toEqual([UIView class]);

    expect(matcher.predicateMatcher).toBeInstanceOf([PredicateMatcher class]);
    expect(matcher.predicateMatcher.matchExpression).toEqual(predicateExpression);
}

- (void)testParsesDescendantCombinatorMatcher {
    SubjectAndAncestorMatcher *matcher = (SubjectAndAncestorMatcher *) [[IgorPattern forPattern:@"UIButton UILabel"] parse];
    expect(matcher).toBeInstanceOf([SubjectAndAncestorMatcher class]);

    NodeMatcher *ancestorMatcher = (NodeMatcher *) matcher.ancestorMatcher;
    expect(ancestorMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorMatcher.classMatcher.matchClass).toEqual([UIButton class]);

    NodeMatcher *descendantMatcher = matcher.subjectMatcher;
    expect(descendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(descendantMatcher.classMatcher.matchClass).toEqual([UILabel class]);
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    SubjectAndAncestorMatcher *matcher = (SubjectAndAncestorMatcher *) [[IgorPattern forPattern:@"UIButton UILabel UIView UITextField"] parse];
    expect(matcher).toBeInstanceOf([SubjectAndAncestorMatcher class]);

    NodeMatcher *descendantMatcher = matcher.subjectMatcher;
    expect(descendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(descendantMatcher.classMatcher.matchClass).toEqual([UITextField class]);

    SubjectAndAncestorMatcher *ancestorMatcher = (SubjectAndAncestorMatcher *) matcher.ancestorMatcher;
    expect(ancestorMatcher).toBeInstanceOf([SubjectAndAncestorMatcher class]);

    NodeMatcher *ancestorDescendantMatcher = ancestorMatcher.subjectMatcher;
    expect(ancestorDescendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorDescendantMatcher.classMatcher.matchClass).toEqual([UIView class]);

    SubjectAndAncestorMatcher *ancestorAncestorMatcher = (SubjectAndAncestorMatcher *) ancestorMatcher.ancestorMatcher;
    expect(ancestorAncestorMatcher).toBeInstanceOf([SubjectAndAncestorMatcher class]);

    NodeMatcher *ancestorAncestorDescendantMatcher = ancestorAncestorMatcher.subjectMatcher;
    expect(ancestorAncestorDescendantMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorAncestorDescendantMatcher.classMatcher.matchClass).toEqual([UILabel class]);

    NodeMatcher *ancestorAncestorAncestorMatcher = (NodeMatcher *) ancestorAncestorMatcher.ancestorMatcher;
    expect(ancestorAncestorAncestorMatcher.classMatcher).toBeInstanceOf([MemberOfClassMatcher class]);
    expect(ancestorAncestorAncestorMatcher.classMatcher.matchClass).toEqual([UIButton class]);
}
@end

