#import "SelectorEngineRegistry.h"

@protocol QueryScanner;
@protocol PatternParser;

@interface Igor : NSObject <SelectorEngine>

@property(strong) id <PatternParser> parser;

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;

+ (Igor *)igor;

+ (Igor *)igorWithParser:(id <PatternParser>)parser;

@end
