@protocol IgorQueryScanner;

@protocol InstanceChainParser <NSObject>

- (void)parseInstanceMatchersFromQuery:(id<IgorQueryScanner>)scanner intoArray:(NSMutableArray*)array;

@end