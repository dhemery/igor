#import "RelationshipMatcher.h"
#import "InstanceParser.h"
#import "InstanceMatcher.h"
#import "RelationshipParser.h"
#import "IgorQueryScanner.h"

@implementation RelationshipParser

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query {
    id <SubjectMatcher> matcher = [InstanceParser parse:query];
    while ([query skipWhiteSpace]) {
        if([query skipString:@"$"]) {
            [query backUp];
            return matcher;
        } else {
            InstanceMatcher *descendantMatcher = [InstanceParser parse:query];
            matcher = [RelationshipMatcher withSubjectMatcher:descendantMatcher ancestorMatcher:matcher];
        }
    }
    return matcher;
}

@end
