#import "ScanningIgorQueryParser.h"
#import "IgorQueryScanner.h"
#import "BranchMatcher.h"
#import "RelationshipParser.h"
#import "CombinatorMatcher.h"

@implementation ScanningIgorQueryParser {
    id <IgorQueryScanner> scanner;
    id <SubjectPatternParser> subjectParser;
    id <CombinatorParser> combinatorParser;
}

- (id <IgorQueryParser>)initWithQueryScanner:(id <IgorQueryScanner>)theScanner relationshipParser:(RelationshipParser *)theRelationshipParser {
    if (self = [super init]) {
        scanner = theScanner;
        subjectParser = theRelationshipParser;
        combinatorParser = theRelationshipParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseMatcherFromQuery:(NSString *)query {
    [scanner setQuery:query];

    id <SubjectMatcher> matcher = [subjectParser parseSubjectMatcher];
    id <Combinator> combinator;

    while ((combinator = [combinatorParser parseCombinator])) {
        id <SubjectMatcher> subjectMatcher = [subjectParser parseSubjectMatcher];
        if (!subjectMatcher) break;
        matcher = [CombinatorMatcher matcherWithSubjectMatcher:subjectMatcher combinator:combinator relativeMatcher:matcher];
    }

    if (combinator) {
        if (![scanner skipString:@"$"]) {
            [scanner failBecause:@"Expected $"];
        }
        id <SubjectMatcher> subjectMatcher = [subjectParser parseSubjectMatcher];
        if (!subjectMatcher) {
            [scanner failBecause:@"Expected a subject pattern after '$'"];
        }
        matcher = [CombinatorMatcher matcherWithSubjectMatcher:subjectMatcher combinator:combinator relativeMatcher:matcher];
        combinator = [combinatorParser parseCombinator];
    }

    if (!matcher) {
        if (![scanner skipString:@"$"]) {
            [scanner failBecause:@"The query must start with a subject pattern"];
        }
        matcher = [subjectParser parseSubjectMatcher];
        if (!matcher) {
            [scanner failBecause:@"Expected a subject pattern after '$'"];
        }
        combinator = [combinatorParser parseCombinator];
    }

    if (combinator) {
        id <SubjectMatcher> branchMatcher = [subjectParser parseSubjectMatcher];
        if (!branchMatcher) {
            NSString *message = [NSString stringWithFormat:@"Expected a subject pattern after '%@'", combinator];
            [scanner failBecause:message];
        }
        id <Combinator> branchCombinator;
        while ((branchCombinator = [combinatorParser parseCombinator])) {
            id <SubjectMatcher> subjectMatcher = [subjectParser parseSubjectMatcher];
            if (!subjectMatcher) {
                NSString *message = [NSString stringWithFormat:@"Expected a subject pattern after '%@'", branchCombinator];
                [scanner failBecause:message];
            }
            branchMatcher = [CombinatorMatcher matcherWithSubjectMatcher:subjectMatcher combinator:branchCombinator relativeMatcher:branchMatcher];
        }
        matcher = [BranchMatcher matcherWithSubjectMatcher:matcher combinator:combinator relativeMatcher:branchMatcher];
    }

    [scanner failIfNotAtEnd];
    return matcher;
}

+ (id <IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner relationshipParser:(RelationshipParser *)relationshipParser {
    return [[self alloc] initWithQueryScanner:scanner relationshipParser:relationshipParser];
}

@end
