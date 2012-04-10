#import "IgorQueryParser.h"
#import "InstanceMatcher.h"
#import "PredicateMatcherForExpression.h"
#import "IgorQueryScanner.h"
#import "KindOfClassMatcherForClass.h"
#import "MemberOfClassMatcherForClass.h"
#import "UniversalMatcher.h"

@interface IgorQueryParserTests : SenTestCase
@end

@implementation IgorQueryParserTests

- (void)testParsesAsteriskAsUniversalMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"*"];
    InstanceMatcher* instanceMatcher = ((InstanceMatcher *) [IgorQueryParser parse:query]);
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
    assertThat(instanceMatcher.simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) [IgorQueryParser parse:query];
    assertThat(instanceMatcher.simpleMatchers, hasItem(memberOfClassMatcherForClass([UIButton class])));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UILabel*"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) [IgorQueryParser parse:query];
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
    assertThat(instanceMatcher.simpleMatchers, hasItem(kindOfClassMatcherForClass([UILabel class])));
}

- (void)testParsesBracketedStringAsPredicateMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"[myPropertyName='somevalue']"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) [IgorQueryParser parse:query];

    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
    assertThat(instanceMatcher.simpleMatchers, hasItem(predicateMatcherForExpression(@"myPropertyName='somevalue'")));
}

/*
- (void)testParsesDescendantCombinatorMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton UILabel"];
    RelationshipMatcher *matcher = (RelationshipMatcher *) [IgorQueryParser parse:query];
    assertThat(matcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *ancestorMatcher = (InstanceMatcher *) matcher.ancestorMatcher;
    assertThat(ancestorMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(ancestorMatcher.classMatcher.matchClass, equalTo([UIButton class]));

    InstanceMatcher *descendantMatcher = matcher.subjectMatcher;
    assertThat(descendantMatcher.classMatcher, instanceOf([MemberOfClassMatcher class]));
    assertThat(descendantMatcher.classMatcher.matchClass, equalTo([UILabel class]));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton UILabel UIView UITextField"];
    RelationshipMatcher *matcher = (RelationshipMatcher *) [IgorQueryParser parse:query];
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
*/
@end

