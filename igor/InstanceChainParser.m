#import "InstanceParser.h"
#import "InstanceChainParser.h"
#import "IgorQueryScanner.h"
#import "ComplexMatcher.h"

@implementation InstanceChainParser

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query {
    id <SubjectMatcher> matcher = [InstanceParser parse:query];
    while ([query skipWhiteSpace]) {
        if([query skipString:@"$"]) {
            [query backUp];
            return matcher;
        } else {
            InstanceMatcher *subject = [InstanceParser parse:query];
            matcher = [ComplexMatcher withHead:matcher subject:subject];
        }
    }
    return matcher;
}

@end
