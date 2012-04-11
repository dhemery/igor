#import "IgorQueryParser.h"
#import "InstanceMatcher.h"
#import "IsPredicateMatcher.h"
#import "IgorQueryScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "UniversalMatcher.h"
#import "ComplexMatcher.h"

@interface IgorQueryParserTests : SenTestCase
@end

@implementation IgorQueryParserTests

- (void)testParsesAsteriskAsUniversalMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"*"];
    ComplexMatcher* matcher = (ComplexMatcher*) [IgorQueryParser parse:query];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject, instanceOf([InstanceMatcher class]));
    assertThat(subject.simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton"];
    ComplexMatcher* matcher = (ComplexMatcher*) [IgorQueryParser parse:query];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UILabel*"];
    ComplexMatcher* matcher = (ComplexMatcher*) [IgorQueryParser parse:query];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesBracketedStringAsPredicateMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"[myPropertyName='somevalue']"];
    ComplexMatcher* matcher = (ComplexMatcher*) [IgorQueryParser parse:query];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsPredicateMatcher forExpression:@"myPropertyName='somevalue'"]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesDescendantCombinatorMatcher {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton UILabel"];
    ComplexMatcher* matcher = (ComplexMatcher*)[IgorQueryParser parse:query];
    assertThat(matcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher* ancestorMatcher = (InstanceMatcher*) matcher.head;
    assertThat(ancestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UILabel class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    IgorQueryScanner *query = [IgorQueryScanner withQuery:@"UIButton UILabel UIView UITextField"];
    ComplexMatcher *matcher = (ComplexMatcher *) [IgorQueryParser parse:query];
    assertThat(matcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UITextField class]]));
    assertThat(subjectMatcher.simpleMatchers, hasCountOf(1));

    ComplexMatcher *ancestorMatcher = (ComplexMatcher *) matcher.head;
    assertThat(ancestorMatcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *ancestorSubjectMatcher = (InstanceMatcher*) ancestorMatcher.subject;
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIView class]]));
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    ComplexMatcher *ancestorAncestorMatcher = (ComplexMatcher *) ancestorMatcher.head;
    assertThat(ancestorAncestorMatcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *ancestorAncestorSubjectMatcher = (InstanceMatcher*) ancestorAncestorMatcher.subject;
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UILabel class]]));
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *ancestorAncestorAncestorMatcher = (InstanceMatcher *) ancestorAncestorMatcher.head;
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forClass:[UIButton class]]));
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasCountOf(1));
}

@end

