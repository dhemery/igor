#import "InstanceParser.h"
#import "ScanningInstanceChainParser.h"
#import "IgorQueryStringScanner.h"
#import "PredicateParser.h"
#import "ClassParser.h"

@implementation ScanningInstanceChainParser {
    InstanceParser *instanceParser;
}

- (id<InstanceChainParser>)init {
    if (self = [super init]) {
        PredicateParser *predicateParser = [PredicateParser parser];
        ClassParser *classParser = [ClassParser parser];
        instanceParser = [InstanceParser parserWithClassParser:classParser predicateParser:predicateParser];
    }
    return self;
}

- (void)parseInstanceMatchersFromQuery:(id<IgorQueryScanner>)scanner intoArray:(NSMutableArray*)instanceMatchers {
    BOOL foundSubjectMarker;
    while(!(foundSubjectMarker = [scanner nextStringIs:@"$"])) {
        id<SubjectMatcher> instanceMatcher = [instanceParser parseInstanceMatcherFromQuery:scanner];
        [instanceMatchers addObject:instanceMatcher];
        NSLog(@"Parsed matcher: %@", instanceMatcher);
        if (![scanner skipWhiteSpace]) {
            NSLog(@"No whitespace. Done parsing chain.");
            return;
        }
    }
    if (foundSubjectMarker) {
        NSLog(@"Hit subject marker. Done parsing chain.");
        return;
    }
    NSLog(@"Reached end of query. Done parsing chain.");
}

+ (id<InstanceChainParser>)parser {
    return [[self alloc] init];
}

@end
