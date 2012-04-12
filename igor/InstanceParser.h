#import "InstanceMatcher.h"
@protocol IgorQueryScanner;
@class ClassParser;
@class PredicateParser;

@interface InstanceParser : NSObject

- (id<SubjectMatcher>)parseInstanceMatcherFromQuery:(id<IgorQueryScanner>)query;

+ (InstanceParser*)parserWithClassParser:(ClassParser*)classParser predicateParser:(PredicateParser*)predicateParser;

@end
