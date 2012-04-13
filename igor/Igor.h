#import "SelectorEngineRegistry.h"

@protocol SubjectChainParser;
@protocol IgorQueryScanner;
@protocol IgorQueryParser;

@interface Igor : NSObject <SelectorEngine>

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;

+ (Igor *)igor;

+ (Igor *)igorWithParser:(id <IgorQueryParser>)parser;

@end
