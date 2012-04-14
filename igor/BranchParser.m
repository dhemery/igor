#import "BranchParser.h"
#import "BranchMatcher.h"
#import "IgorQueryScanner.h"
#import "RelationshipParser.h"
#import "CombinatorMatcher.h"

@implementation BranchParser {
    id <IgorQueryScanner> scanner;
    id <SubjectPatternParser> subjectParser;
    id <CombinatorParser> combinatorParser;
}
- (id <SubjectPatternParser>)initWithScanner:(id <IgorQueryScanner>)aScanner relationshipParser:(RelationshipParser *)theRelationshipParser {
    self = [super init];
    if (self) {
        scanner = aScanner;
        subjectParser = theRelationshipParser;
        combinatorParser = theRelationshipParser;
    }
    return self;
}

- (id <SubjectMatcher>)parseBranchMatcher {
    id <SubjectMatcher> matcher;
    id <SubjectMatcher> branchSubjectMatcher = [subjectParser parseSubjectMatcher];
    if (!branchSubjectMatcher) {
        [scanner failBecause:@"Expected a subject pattern after '('"];
    }
    id <Combinator> branchTestCombinator = [combinatorParser parseCombinator];
    if (branchTestCombinator) {
        id <SubjectMatcher> branchTestMatcher = [self parseBranchTest];
        matcher = [BranchMatcher matcherWithSubjectMatcher:branchSubjectMatcher combinator:branchTestCombinator relativeMatcher:branchTestMatcher];
    } else {
        matcher = branchSubjectMatcher;
    }
    return matcher;
}

- (id <SubjectMatcher>)parseBranchTest {
    id <SubjectMatcher> matcher = [subjectParser parseSubjectMatcher];
    if (!matcher) {
        [scanner failBecause:@"Expected a subject pattern"];
    }
    id <Combinator> combinator;
    while ((combinator = [combinatorParser parseCombinator])) {
        id <SubjectMatcher> subjectMatcher = [subjectParser parseSubjectMatcher];
        if (!subjectMatcher) {
            NSString *message = [NSString stringWithFormat:@"Expected a subject pattern after '%@'", combinator];
            [scanner failBecause:message];
        }
        matcher = [CombinatorMatcher matcherWithSubjectMatcher:subjectMatcher combinator:combinator relativeMatcher:matcher];
    }
    return matcher;
}

- (id <SubjectMatcher>)parseSubjectMatcher {
    if (![scanner skipString:@"("]) return nil;
    id <SubjectMatcher> matcher = [self parseBranchMatcher];
    if (![scanner skipString:@")"]) {
        [scanner failBecause:@"Expected ')'"];
    }
    return matcher;
}

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner relationshipParser:(RelationshipParser *)relationshipParser {
    return [[self alloc] initWithScanner:scanner relationshipParser:relationshipParser];
}

@end
