#import "InstanceParser.h"
#import "InstanceChainParser.h"
#import "IgorQueryStringScanner.h"

@implementation InstanceChainParser

+ (void)collectInstanceMatchersFromQuery:(id<IgorQueryScanner>)query intoArray:(NSMutableArray*)array {
    BOOL foundSubjectMarker;
    while(!(foundSubjectMarker = [query nextStringIs:@"$"])) {
        InstanceMatcher *matcher = [InstanceParser instanceMatcherFromQuery:query];
        [array addObject:matcher];
        NSLog(@"Parsed matcher: %@", matcher);
        if (![query skipWhiteSpace]) {
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

@end
