@class InstanceMatcher;
@class IgorQueryScanner;

@interface InstanceParser

+ (InstanceMatcher *)parse:(IgorQueryScanner *)query;

@end
