#import "IgorQuery.h"
#import "ClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "KindOfClassMatcher.h"
#import "InstanceMatcher.h"
#import "PredicateMatcher.h"
#import "RelationshipMatcher.h"

@interface IgorQueryParserTests : SenTestCase
@end

@implementation IgorQueryParserTests

- (void)testParsesAsteriskAsKindOfClassMatcherForUIViewClass {
    id<ClassMatcher> matcher = ((InstanceMatcher *) [[IgorQuery forPattern:@"*"] parse]).classMatcher;
    assertThat(matcher, instanceOf([KindOfClassMatcher class]));
    assertThat(matcher.matchClass, equalTo([UIView class]));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    InstanceMatcher *matcher = (InstanceMatcher *) [[IgorQuery forPattern:@"UIButton"] parse];
    assertThat(matcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(matcher.classMatcher.matchClass, equalTo([UIButton class]));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    InstanceMatcher *matcher = (InstanceMatcher *) [[IgorQuery forPattern:@"UILabel*"] parse];
    assertThat(matcher.classMatcher, instanceOf([KindOfClassMatcher class]));
    assertThat(matcher.classMatcher.matchClass, equalTo([UILabel class]));
}

- (void)testParsesNodeMatcherWithPredicateMatcher {
    NSString *predicateExpression = [[NSPredicate predicateWithFormat:@"myPropertyName='somevalue'"] predicateFormat];
    InstanceMatcher *matcher = (InstanceMatcher *) [[IgorQuery forPattern:@"*[myPropertyName='somevalue']"] parse];

    assertThat(matcher.classMatcher, instanceOf([KindOfClassMatcher class]));
    assertThat(matcher.classMatcher.matchClass, equalTo([UIView class]));

    PredicateMatcher *predicateMatcher = [matcher predicateMatcher];
    assertThat(predicateMatcher, instanceOf([PredicateMatcher class]));
    assertThat(predicateMatcher.matchExpression, equalTo(predicateExpression));
}

- (void)testParsesDescendantCombinatorMatcher {
    RelationshipMatcher *matcher = (RelationshipMatcher *) [[IgorQuery forPattern:@"UIButton UILabel"] parse];
    assertThat(matcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *ancestorMatcher = (InstanceMatcher *) matcher.ancestorMatcher;
    assertThat(ancestorMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorMatcher.classMatcher.matchClass, equalTo([UIButton class]));

    InstanceMatcher *descendantMatcher = matcher.subjectMatcher;
    assertThat(descendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(descendantMatcher.classMatcher.matchClass, equalTo([UILabel class]));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    RelationshipMatcher *matcher = (RelationshipMatcher *) [[IgorQuery forPattern:@"UIButton UILabel UIView UITextField"] parse];
    assertThat(matcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *descendantMatcher = matcher.subjectMatcher;
    assertThat(descendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(descendantMatcher.classMatcher.matchClass, equalTo([UITextField class]));

    RelationshipMatcher *ancestorMatcher = (RelationshipMatcher *) matcher.ancestorMatcher;
    assertThat(ancestorMatcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *ancestorDescendantMatcher = ancestorMatcher.subjectMatcher;
    assertThat(ancestorDescendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorDescendantMatcher.classMatcher.matchClass, equalTo([UIView class]));

    RelationshipMatcher *ancestorAncestorMatcher = (RelationshipMatcher *) ancestorMatcher.ancestorMatcher;
    assertThat(ancestorAncestorMatcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *ancestorAncestorDescendantMatcher = ancestorAncestorMatcher.subjectMatcher;
    assertThat(ancestorAncestorDescendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorAncestorDescendantMatcher.classMatcher.matchClass, equalTo([UILabel class]));

    InstanceMatcher *ancestorAncestorAncestorMatcher = (InstanceMatcher *) ancestorAncestorMatcher.ancestorMatcher;
    assertThat(ancestorAncestorAncestorMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorAncestorAncestorMatcher.classMatcher.matchClass, equalTo([UIButton class]));
}
@end

