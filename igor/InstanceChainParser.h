@protocol SubjectMatcher;
@class IgorQueryScanner;

@interface InstanceChainParser

+ (void)collectInstanceMatchersFromQuery:(IgorQueryScanner *)query intoArray:(NSMutableArray*)array;

@end
