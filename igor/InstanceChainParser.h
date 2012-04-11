@protocol SubjectMatcher;
@class IgorQueryScanner;

@interface InstanceChainParser

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query;

@end
