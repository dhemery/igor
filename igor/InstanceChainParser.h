@protocol IgorQueryScanner;

@interface InstanceChainParser

+ (void)collectInstanceMatchersFromQuery:(id<IgorQueryScanner>)query intoArray:(NSMutableArray*)array;

@end
