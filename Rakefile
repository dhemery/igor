require 'rake/clean'

LIBNAME = "libIgor.a"
DIST = 'dist'
BUILD = 'build'

directory DIST
directory BUILD
$version = `agvtool vers -terse`.strip
$libname = "libIgor#{$version}.a"
$debuglibname = "libIgorDebug#{$version}.a"
$dist_dir = 'dist'
$build_dir = 'build'

CLEAN.include BUILD, DIST

task :default => [:clean, :all]

desc "Build the universal library release version for distribution"
task :all => [:iphone, :simulator, DIST] do
    `lipo -create -output "#{DIST}/#{LIBNAME}" "#{BUILD}/Release-iphoneos/#{LIBNAME}" "#{BUILD}/Release-iphonesimulator/#{LIBNAME}"`
end

desc "Build the iPhone library release version"
task :iphone do
    build_for("iphoneos")
end

desc "Build the simulator library release version"
task :simulator do
    build_for("iphonesimulator")
end

def build_for(sdkname)
    sh "xcodebuild -sdk #{sdkname} -configuration Release BUILD_DIR=#{BUILD} clean build"
end
