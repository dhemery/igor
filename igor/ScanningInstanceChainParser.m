#import "InstanceParser.h"
#import "ScanningInstanceChainParser.h"
#import "IgorQueryStringScanner.h"

@implementation ScanningInstanceChainParser {
    id<IgorQueryScanner> scanner;
}

- (id<InstanceChainParser>)initWithQueryScanner:(id <IgorQueryScanner>)theScanner {
    if (self = [super init]) {
        scanner = theScanner;
    }
    return self;
}

- (void)collectInstanceMatchersIntoArray:(NSMutableArray*)array {
    BOOL foundSubjectMarker;
    while(!(foundSubjectMarker = [scanner nextStringIs:@"$"])) {
        InstanceMatcher *matcher = [InstanceParser instanceMatcherFromQuery:scanner];
        [array addObject:matcher];
        NSLog(@"Parsed matcher: %@", matcher);
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

+ (id<InstanceChainParser>)withQueryScanner:(id <IgorQueryScanner>)scanner {
    return [[self alloc] initWithQueryScanner:scanner];
}


@end
