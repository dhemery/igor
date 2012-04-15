#import "BranchParser.h"
#import "BranchMatcher.h"
#import "IgorQueryScanner.h"
#import "SubjectChainParser.h"

@implementation BranchParser {
    id <IgorQueryScanner> scanner;
    SubjectChainParser *subjectChainParser;
}

- (id <SubjectPatternParser>)initWithScanner:(id <IgorQueryScanner>)aScanner subjectChainParser:(SubjectChainParser *)theSubjectChainParser {
    self = [super init];
    if (self) {
        scanner = aScanner;
        subjectChainParser = theSubjectChainParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseBranchMatcher {
    SubjectChain *subject = [subjectChainParser parseOneSubject];

    if (!subject.started) [scanner failBecause:@"Expected a relationship pattern"];

    if (subject.done) return subject.matcher;

    SubjectChain * relative = [subjectChainParser parseSubjectChain];
    if (!relative.done) [scanner failBecause:@"Expected a subject pattern"];
    return [BranchMatcher matcherWithSubjectMatcher:subject.matcher combinator:subject.combinator relativeMatcher:relative.matcher];
}

- (id <SubjectMatcher>)parseSubjectMatcher {
    if (![scanner skipString:@"("]) return nil;
    id <SubjectMatcher> matcher = [self parseBranchMatcher];
    if (![scanner skipString:@")"]) {
        [scanner failBecause:@"Expected ')'"];
    }
    return matcher;
}

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(SubjectChainParser *)subjectChainParser {
    return [[self alloc] initWithScanner:scanner subjectChainParser:subjectChainParser];
}

@end
