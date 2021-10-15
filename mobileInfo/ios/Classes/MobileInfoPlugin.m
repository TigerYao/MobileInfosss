#import "MobileInfoPlugin.h"
#if __has_include(<mobile_info/mobile_info-Swift.h>)
#import <mobile_info/mobile_info-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mobile_info-Swift.h"
#endif

@implementation MobileInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMobileInfoPlugin registerWithRegistrar:registrar];
}
@end
