#import "ScanningIgorQueryParser.h"
#import "IgorQueryScanner.h"
#import "ComplexMatcher.h"
#import "UniversalMatcher.h"

@implementation ScanningIgorQueryParser {
    id <IgorQueryScanner> scanner;
    id <SubjectChainParser> instanceChainParser;
}

- (id <IgorQueryParser>)initWithQueryScanner:(id <IgorQueryScanner>)theScanner instanceChainParser:(id <SubjectChainParser>)theInstanceChainParser {
    if (self = [super init]) {
        scanner = theScanner;
        instanceChainParser = theInstanceChainParser;
    }
    return self;
}

- (id <SubjectMatcher>)subjectMatcherFromMatcherChain:(NSArray *)matcherChain {
    if ([matcherChain count] == 0) {
        return [UniversalMatcher new];
    }
    if ([matcherChain count] == 1) {
        return [matcherChain lastObject];
    }
    id <SubjectMatcher> matcher = [matcherChain objectAtIndex:0];
    for (NSUInteger i = 1; i < [matcherChain count]; i++) {
        matcher = [ComplexMatcher matcherWithHead:matcher subject:[matcherChain objectAtIndex:i]];
    }
    return matcher;
}

- (id <SubjectMatcher>)parseMatcherFromQuery:(NSString *)query {
    [scanner setQuery:query];
    NSMutableArray *head = [NSMutableArray array];
    NSMutableArray *tail = [NSMutableArray array];

    [instanceChainParser parseSubjectMatchersIntoArray:head];
    if ([scanner skipString:@"$"]) {
        [instanceChainParser parseSubjectMatcherIntoArray:head];
    }
    id <SubjectMatcher> subject = [head lastObject];
    [head removeLastObject];
    if ([scanner skipWhiteSpace]) {
        [instanceChainParser parseSubjectMatchersIntoArray:tail];
    }
    [scanner failIfNotAtEnd];
    id <SubjectMatcher> matcher = [ComplexMatcher matcherWithHead:[self subjectMatcherFromMatcherChain:head] subject:subject tail:[self subjectMatcherFromMatcherChain:tail]];
    return matcher;
}

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner instanceChainParser:(id <SubjectChainParser>)instanceChainParser {
    return [[self alloc] initWithQueryScanner:scanner instanceChainParser:instanceChainParser];
}

@end
