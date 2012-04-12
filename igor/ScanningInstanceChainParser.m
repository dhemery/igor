#import "ScanningInstanceParser.h"
#import "ScanningInstanceChainParser.h"
#import "IgorQueryStringScanner.h"

@implementation ScanningInstanceChainParser {
    id<InstanceParser> instanceParser;
    id<IgorQueryScanner> scanner;
}

- (id<InstanceChainParser>)initWithScanner:(id<IgorQueryScanner>)theScanner instanceParser:(id<InstanceParser>)theInstanceParser {
    if (self = [super init]) {
        scanner = theScanner;
        instanceParser = theInstanceParser;
    }
    return self;
}

- (void)parseInstanceMatchersIntoArray:(NSMutableArray*)instanceMatchers {
    BOOL foundSubjectMarker;
    while(!(foundSubjectMarker = [scanner nextStringIs:@"$"])) {
        id<SubjectMatcher> instanceMatcher = [instanceParser parseInstanceMatcher];
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

+ (id<InstanceChainParser>)parserWithScanner:(id<IgorQueryScanner>)scanner instanceParser:(id<InstanceParser>)instanceParser {
    return [[self alloc] initWithScanner:scanner instanceParser:instanceParser];
}

@end
