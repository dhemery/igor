#import "SubjectOnRightMatcher.h"
#import "InstanceParser.h"
#import "InstanceMatcher.h"
#import "InstanceChainParser.h"
#import "IgorQueryScanner.h"

@implementation InstanceChainParser

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query {
    id <SubjectMatcher> matcher = [InstanceParser parse:query];
    while ([query skipWhiteSpace]) {
        if([query skipString:@"$"]) {
            [query backUp];
            return matcher;
        } else {
            InstanceMatcher *subject = [InstanceParser parse:query];
            matcher = [SubjectOnRightMatcher withSubject:subject head:matcher];
        }
    }
    return matcher;
}

@end
