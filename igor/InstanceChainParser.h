@protocol SubjectMatcher;
@class IgorQueryScanner;

@interface InstanceChainParser

+ (void)parse:(IgorQueryScanner *)query intoArray:(NSMutableArray*)array;

@end
