#import "ScanningIgorQueryParser.h"
#import "IgorQueryScanner.h"
#import "BranchMatcher.h"
#import "CombinatorMatcher.h"
#import "ChainParser.h"

@implementation ScanningIgorQueryParser {
    id <IgorQueryScanner> scanner;
    ChainParser *subjectChainParser;
}

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(ChainParser *)subjectChainParser {
    return [[self alloc] initWithScanner:scanner subjectChainParser:subjectChainParser];
}

- (id <IgorQueryParser>)initWithScanner:(id <IgorQueryScanner>)theScanner subjectChainParser:(ChainParser *)theSubjectChainParser {
    self = [super init];
    if (self) {
        scanner = theScanner;
        subjectChainParser = theSubjectChainParser;
    }
    return self;
}

- (id <Matcher>)parseMatcherFromQuery:(NSString *)queryString {
    [scanner setQuery:queryString];

    id <Matcher> matcher = [self parseSubject];
    if (!subjectChainParser.done) matcher = [self parseBranchMatcherWithSubject:matcher];
    if (!subjectChainParser.done) [scanner failBecause:@"Expected a subject pattern"];
    [scanner failIfNotAtEnd];
    return matcher;
}

- (id <Matcher>)parseSubject {
    id <Matcher> subject = [subjectChainParser parseStep];
    if (subjectChainParser.done) return subject;
    id <ChainMatcher> compoundSubject = [CombinatorMatcher matcherWithSubjectMatcher:subject];
    [subjectChainParser parseSubjectChainIntoMatcher:compoundSubject];
    if (subjectChainParser.done) return compoundSubject;
    if (![scanner skipString:@"$"]) [scanner failBecause:@"Expected a subject marker"];
    if (subjectChainParser.started) {
        [self parseStepIntoMatcher:compoundSubject];
        return compoundSubject;
    }
    return [subjectChainParser parseStep];
}

- (void)parseStepIntoMatcher:(id <ChainMatcher>)subject {
    id <Combinator> combinator = subjectChainParser.combinator;
    id <Matcher> matcher = [subjectChainParser parseStep];
    [subject appendCombinator:combinator matcher:matcher];
}

- (id <Matcher>)parseBranchMatcherWithSubject:(id <Matcher>)subject {
    id <ChainMatcher> branch = [BranchMatcher matcherWithSubjectMatcher:subject];
    [subjectChainParser parseSubjectChainIntoMatcher:branch];
    return branch;
}

@end
