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
    assertThat(matcher, instanceOf([KindOfClassMatcher class]));
    assertThat(matcher.matchClass, equalTo([UIView class]));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    NodeMatcher *matcher = (NodeMatcher *) [[IgorPattern forPattern:@"UIButton"] parse];
    assertThat(matcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(matcher.classMatcher.matchClass, equalTo([UIButton class]));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    NodeMatcher *matcher = (NodeMatcher *) [[IgorPattern forPattern:@"UILabel*"] parse];
    assertThat(matcher.classMatcher, instanceOf([KindOfClassMatcher class]));
    assertThat(matcher.classMatcher.matchClass, equalTo([UILabel class]));
}

- (void)testParsesNodeMatcherWithPredicateMatcher {
    NSString *predicateExpression = [[NSPredicate predicateWithFormat:@"myPropertyName='somevalue'"] predicateFormat];
    NodeMatcher *matcher = (NodeMatcher *) [[IgorPattern forPattern:@"*[myPropertyName='somevalue']"] parse];

    assertThat(matcher.classMatcher, instanceOf([KindOfClassMatcher class]));
    assertThat(matcher.classMatcher.matchClass, equalTo([UIView class]));

    assertThat(matcher.predicateMatcher, instanceOf([PredicateMatcher class]));
    assertThat(matcher.predicateMatcher.matchExpression, equalTo(predicateExpression));
}

- (void)testParsesDescendantCombinatorMatcher {
    SubjectAndAncestorMatcher *matcher = (SubjectAndAncestorMatcher *) [[IgorPattern forPattern:@"UIButton UILabel"] parse];
    assertThat(matcher, instanceOf([SubjectAndAncestorMatcher class]));

    NodeMatcher *ancestorMatcher = (NodeMatcher *) matcher.ancestorMatcher;
    assertThat(ancestorMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorMatcher.classMatcher.matchClass, equalTo([UIButton class]));

    NodeMatcher *descendantMatcher = matcher.subjectMatcher;
    assertThat(descendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(descendantMatcher.classMatcher.matchClass, equalTo([UILabel class]));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    SubjectAndAncestorMatcher *matcher = (SubjectAndAncestorMatcher *) [[IgorPattern forPattern:@"UIButton UILabel UIView UITextField"] parse];
    assertThat(matcher, instanceOf([SubjectAndAncestorMatcher class]));

    NodeMatcher *descendantMatcher = matcher.subjectMatcher;
    assertThat(descendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(descendantMatcher.classMatcher.matchClass, equalTo([UITextField class]));

    SubjectAndAncestorMatcher *ancestorMatcher = (SubjectAndAncestorMatcher *) matcher.ancestorMatcher;
    assertThat(ancestorMatcher, instanceOf([SubjectAndAncestorMatcher class]));

    NodeMatcher *ancestorDescendantMatcher = ancestorMatcher.subjectMatcher;
    assertThat(ancestorDescendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorDescendantMatcher.classMatcher.matchClass, equalTo([UIView class]));

    SubjectAndAncestorMatcher *ancestorAncestorMatcher = (SubjectAndAncestorMatcher *) ancestorMatcher.ancestorMatcher;
    assertThat(ancestorAncestorMatcher, instanceOf([SubjectAndAncestorMatcher class]));

    NodeMatcher *ancestorAncestorDescendantMatcher = ancestorAncestorMatcher.subjectMatcher;
    assertThat(ancestorAncestorDescendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorAncestorDescendantMatcher.classMatcher.matchClass, equalTo([UILabel class]));

    NodeMatcher *ancestorAncestorAncestorMatcher = (NodeMatcher *) ancestorAncestorMatcher.ancestorMatcher;
    assertThat(ancestorAncestorAncestorMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorAncestorAncestorMatcher.classMatcher.matchClass, equalTo([UIButton class]));
}
@end

