#import "IgorQueryParser.h"
#import "InstanceMatcher.h"
#import "IsPredicateMatcher.h"
#import "IgorQueryScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "RelationshipMatcher.h"
#import "UniversalMatcher.h"

@interface IgorQueryParserTests : SenTestCase
@end

@implementation IgorQueryParserTests

- (void)testParsesAsteriskAsUniversalMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"*"];
    InstanceMatcher* instanceMatcher = ((InstanceMatcher *) [IgorQueryParser parse:query]);

    assertThat(instanceMatcher.simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) [IgorQueryParser parse:query];

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UILabel*"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) [IgorQueryParser parse:query];

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesBracketedStringAsPredicateMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"[myPropertyName='somevalue']"];
    InstanceMatcher *instanceMatcher = (InstanceMatcher *) [IgorQueryParser parse:query];

    assertThat(instanceMatcher.simpleMatchers, hasItem([IsPredicateMatcher forExpression:@"myPropertyName='somevalue'"]));
    assertThat(instanceMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesDescendantCombinatorMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton UILabel"];
    RelationshipMatcher* matcher = (RelationshipMatcher*) [IgorQueryParser parse:query];
    assertThat(matcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *ancestorMatcher = (InstanceMatcher*) matcher.ancestorMatcher;
    assertThat(ancestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subjectMatcher;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UILabel class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton UILabel UIView UITextField"];
    RelationshipMatcher *matcher = (RelationshipMatcher *) [IgorQueryParser parse:query];
    assertThat(matcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subjectMatcher;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UITextField class]]));
    assertThat(subjectMatcher.simpleMatchers, hasCountOf(1));

    RelationshipMatcher *ancestorMatcher = (RelationshipMatcher *) matcher.ancestorMatcher;
    assertThat(ancestorMatcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *ancestorSubjectMatcher = (InstanceMatcher*) ancestorMatcher.subjectMatcher;
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIView class]]));
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    RelationshipMatcher *ancestorAncestorMatcher = (RelationshipMatcher *) ancestorMatcher.ancestorMatcher;
    assertThat(ancestorAncestorMatcher, instanceOf([RelationshipMatcher class]));

    InstanceMatcher *ancestorAncestorSubjectMatcher = (InstanceMatcher*) ancestorAncestorMatcher.subjectMatcher;
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UILabel class]]));
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *ancestorAncestorAncestorMatcher = (InstanceMatcher *) ancestorAncestorMatcher.ancestorMatcher;
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasCountOf(1));
}

@end

