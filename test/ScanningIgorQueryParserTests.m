#import "ScanningIgorQueryParser.h"
#import "InstanceMatcher.h"
#import "IsPredicateMatcher.h"
#import "IgorQueryStringScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "UniversalMatcher.h"
#import "ComplexMatcher.h"
#import "ScanningInstanceChainParser.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "ClassParser.h"

@interface ScanningIgorQueryParserTests : SenTestCase
@end

@implementation ScanningIgorQueryParserTests {
    id <IgorQueryParser> parser;
}

- (void)setUp {
    id <IgorQueryScanner> scanner = [IgorQueryStringScanner scanner];
    NSArray *simplePatternParsers = [NSArray arrayWithObjects:[ClassParser parserWithScanner:scanner], [PredicateParser parserWithScanner:scanner], nil];
    NSArray *subjectPatternParsers = [NSArray arrayWithObject:[InstanceParser parserWithSimplePatternParsers:simplePatternParsers]];
    id <InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser parserWithScanner:scanner subjectPatternParsers:subjectPatternParsers];
    parser = [ScanningIgorQueryParser parserWithScanner:scanner instanceParser:[subjectPatternParsers lastObject] instanceChainParser:instanceChainParser];
}

- (void)testParsesAsteriskAsUniversalMatcher {
    ComplexMatcher *matcher = (ComplexMatcher *) [parser parseMatcherFromQuery:@"*"];
    InstanceMatcher *subject = (InstanceMatcher *) matcher.subject;

    assertThat(subject, instanceOf([InstanceMatcher class]));
    assertThat(subject.simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    ComplexMatcher *matcher = (ComplexMatcher *) [parser parseMatcherFromQuery:@"UIButton"];
    InstanceMatcher *subject = (InstanceMatcher *) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    ComplexMatcher *matcher = (ComplexMatcher *) [parser parseMatcherFromQuery:@"UILabel*"];
    InstanceMatcher *subject = (InstanceMatcher *) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesBracketedStringAsPredicateMatcher {
    ComplexMatcher *matcher = (ComplexMatcher *) [parser parseMatcherFromQuery:@"[myPropertyName='somevalue']"];
    InstanceMatcher *subject = (InstanceMatcher *) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsPredicateMatcher forExpression:@"myPropertyName='somevalue'"]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesDescendantCombinatorMatcher {
    ComplexMatcher *matcher = (ComplexMatcher *) [parser parseMatcherFromQuery:@"UIButton UILabel"];
    assertThat(matcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *ancestorMatcher = (InstanceMatcher *) matcher.head;
    assertThat(ancestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *subjectMatcher = (InstanceMatcher *) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UILabel class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    ComplexMatcher *matcher = (ComplexMatcher *) [parser parseMatcherFromQuery:@"UIButton UILabel UIView UITextField"];
    assertThat(matcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *subjectMatcher = (InstanceMatcher *) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UITextField class]]));
    assertThat(subjectMatcher.simpleMatchers, hasCountOf(1));

    ComplexMatcher *ancestorMatcher = (ComplexMatcher *) matcher.head;
    assertThat(ancestorMatcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *ancestorSubjectMatcher = (InstanceMatcher *) ancestorMatcher.subject;
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIView class]]));
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    ComplexMatcher *ancestorAncestorMatcher = (ComplexMatcher *) ancestorMatcher.head;
    assertThat(ancestorAncestorMatcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *ancestorAncestorSubjectMatcher = (InstanceMatcher *) ancestorAncestorMatcher.subject;
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UILabel class]]));
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *ancestorAncestorAncestorMatcher = (InstanceMatcher *) ancestorAncestorMatcher.head;
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasCountOf(1));
}

@end

