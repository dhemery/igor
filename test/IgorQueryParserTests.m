#import "IgorQueryParser.h"
#import "InstanceMatcher.h"
#import "IsPredicateMatcher.h"
#import "IgorQueryStringScanner.h"
#import "IsKindOfClassMatcher.h"
#import "IsMemberOfClassMatcher.h"
#import "UniversalMatcher.h"
#import "ComplexMatcher.h"
#import "ScanningInstanceChainParser.h"

@interface IgorQueryParserTests : SenTestCase
@end

@implementation IgorQueryParserTests

- (void)testParsesAsteriskAsUniversalMatcher {
    id<IgorQueryScanner> scanner = [IgorQueryStringScanner withQueryString:@"*"];
    id<InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser withQueryScanner:scanner];
    ComplexMatcher* matcher = (ComplexMatcher*) [[IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser] nextMatcher];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject, instanceOf([InstanceMatcher class]));
    assertThat(subject.simpleMatchers, hasItem(instanceOf([UniversalMatcher class])));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsMemberOfClassMatcher {
    id<IgorQueryScanner> scanner = [IgorQueryStringScanner withQueryString:@"UIButton"];
    id<InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser withQueryScanner:scanner];
    ComplexMatcher* matcher = (ComplexMatcher*) [[IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser] nextMatcher];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesNameAsteriskAsKindOfClassMatcher {
    id<IgorQueryScanner> scanner = [IgorQueryStringScanner withQueryString:@"UILabel*"];
    id<InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser withQueryScanner:scanner];
    ComplexMatcher* matcher = (ComplexMatcher*) [[IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser] nextMatcher];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsKindOfClassMatcher forClass:[UILabel class]]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesBracketedStringAsPredicateMatcher {
    id<IgorQueryScanner> scanner = [IgorQueryStringScanner withQueryString:@"[myPropertyName='somevalue']"];
    id<InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser withQueryScanner:scanner];
    ComplexMatcher* matcher = (ComplexMatcher*) [[IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser] nextMatcher];
    InstanceMatcher* subject = (InstanceMatcher*) matcher.subject;

    assertThat(subject.simpleMatchers, hasItem([IsPredicateMatcher forExpression:@"myPropertyName='somevalue'"]));
    assertThat(subject.simpleMatchers, hasCountOf(1));
}

- (void)testParsesDescendantCombinatorMatcher {
    id<IgorQueryScanner> scanner = [IgorQueryStringScanner withQueryString:@"UIButton UILabel"];
    id<InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser withQueryScanner:scanner];
    ComplexMatcher* matcher = (ComplexMatcher*) [[IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser] nextMatcher];
    assertThat(matcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher* ancestorMatcher = (InstanceMatcher*) matcher.head;
    assertThat(ancestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UILabel class]]));
    assertThat(ancestorMatcher.simpleMatchers, hasCountOf(1));
}

- (void)testParsesMultipleDescendantCombinatorMatchers {
    id<IgorQueryScanner> scanner = [IgorQueryStringScanner withQueryString:@"UIButton UILabel UIView UITextField"];
    id<InstanceChainParser> instanceChainParser = [ScanningInstanceChainParser withQueryScanner:scanner];
    ComplexMatcher *matcher = (ComplexMatcher *) [[IgorQueryParser withQueryScanner:scanner instanceChainParser:instanceChainParser] nextMatcher];
    assertThat(matcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *subjectMatcher = (InstanceMatcher*) matcher.subject;
    assertThat(subjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UITextField class]]));
    assertThat(subjectMatcher.simpleMatchers, hasCountOf(1));

    ComplexMatcher *ancestorMatcher = (ComplexMatcher *) matcher.head;
    assertThat(ancestorMatcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *ancestorSubjectMatcher = (InstanceMatcher*) ancestorMatcher.subject;
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIView class]]));
    assertThat(ancestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    ComplexMatcher *ancestorAncestorMatcher = (ComplexMatcher *) ancestorMatcher.head;
    assertThat(ancestorAncestorMatcher, instanceOf([ComplexMatcher class]));

    InstanceMatcher *ancestorAncestorSubjectMatcher = (InstanceMatcher*) ancestorAncestorMatcher.subject;
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UILabel class]]));
    assertThat(ancestorAncestorSubjectMatcher.simpleMatchers, hasCountOf(1));

    InstanceMatcher *ancestorAncestorAncestorMatcher = (InstanceMatcher *) ancestorAncestorMatcher.head;
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasItem([IsMemberOfClassMatcher forExactClass:[UIButton class]]));
    assertThat(ancestorAncestorAncestorMatcher.simpleMatchers, hasCountOf(1));
}

@end

