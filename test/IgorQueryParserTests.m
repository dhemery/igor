#import "IgorQueryParser.h"
#import "InstanceMatcher.h"
#import "IsPredicateMatcher.h"
#import "IgorQueryScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "SubjectOnRightMatcher.h"
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
    SubjectOnRightMatcher * matcher = (SubjectOnRightMatcher *) [IgorQueryParser parse:query];
    assertThat(matcher, instanceOf([SubjectOnRightMatcher class]));

    InstanceMatcher *ancestorMatcher = (InstanceMatcher*) matcher.head;
    assertThat(ancestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UILabel class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton UILabel UIView UITextField"];
    SubjectOnRightMatcher *matcher = (SubjectOnRightMatcher *) [IgorQueryParser parse:query];
    assertThat(matcher, instanceOf([SubjectOnRightMatcher class]));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UITextField class]]));
    assertThat(subjectMatcher.simpleMatchers, hasCountOf(1));

    SubjectOnRightMatcher *ancestorMatcher = (SubjectOnRightMatcher *) matcher.head;
    assertThat(ancestorMatcher, instanceOf([SubjectOnRightMatcher class]));

    InstanceMatcher *ancestorSubjectMatcher = (InstanceMatcher*) ancestorMatcher.subject;
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIView class]]));
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    SubjectOnRightMatcher *ancestorAncestorMatcher = (SubjectOnRightMatcher *) ancestorMatcher.head;
    assertThat(ancestorAncestorMatcher, instanceOf([SubjectOnRightMatcher class]));

    InstanceMatcher *ancestorAncestorSubjectMatcher = (InstanceMatcher*) ancestorAncestorMatcher.subject;
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UILabel class]]));
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *ancestorAncestorAncestorMatcher = (InstanceMatcher *) ancestorAncestorMatcher.head;
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasCountOf(1));
}

@end

