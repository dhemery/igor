#import "InstanceParser.h"
#import "InstanceChainParser.h"
#import "IgorQueryScanner.h"

@implementation InstanceChainParser

+ (void)parse:(IgorQueryScanner *)query intoArray:(NSMutableArray*)matchers {
    BOOL foundSubjectMarker;
    while(!(foundSubjectMarker = [query skipString:@"$"])) {
        InstanceMatcher *matcher = [InstanceParser parse:query];
        [matchers addObject:matcher];
        NSLog(@"Parsed matcher: %@", matcher);
        if (![query skipWhiteSpace]) {
            NSLog(@"No whitespace. Done parsing chain.");
            return;
        }
    }
    if (foundSubjectMarker) {
        NSLog(@"Hit subject marker. Done parsing chain.");
        [query backUp];
        return;
    }
    NSLog(@"Reached end of query. Done parsing chain.");
}

@end
