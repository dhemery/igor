require 'rake/clean'

$version = `agvtool vers -terse`.strip
$libname = "libIgor.a"
$debuglibname = "libIgorDebug#{$version}.a"
$dist_dir = 'dist'
$build_dir = 'build'

directory $dist_dir
directory $build_dir

CLEAN.include $build_dir, $dist_dir

task :default => [:clean, :release]

task :all => [:debug, :release]

desc "Build the universal library debug version"
task :debug => [:iphone_debug, :simulator_debug, $dist_dir] do
    `lipo -create -output "#{$dist_dir}/#{$debuglibname}" "#{$build_dir}/Debug-iphoneos/#{$libname}" "#{$build_dir}/Debug-iphonesimulator/#{$libname}"`
end

desc "Build the iPhone library debug version for distribution"
task :iphone_debug do
    sh "xcodebuild -sdk iphoneos -configuration Debug BUILD_DIR=#{$build_dir} clean build"
end

desc "Build the iPhone library release version"
task :iphone_release do
    sh "xcodebuild -sdk iphoneos -configuration Release BUILD_DIR=#{$build_dir} clean build"
end

desc "Build the universal library release version for distribution"
task :release => [:iphone_release, :simulator_release, $dist_dir] do
    `lipo -create -output "#{$dist_dir}/#{$libname}" "#{$build_dir}/Release-iphoneos/#{$libname}" "#{$build_dir}/Release-iphonesimulator/#{$libname}"`
end

desc "Build the simulator library debug version"
task :simulator_debug do
    sh "xcodebuild -sdk iphonesimulator -configuration Debug BUILD_DIR=#{$build_dir} clean build"
end

desc "Build the simulator library release version"
task :simulator_release do
    sh "xcodebuild -sdk iphonesimulator -configuration Release BUILD_DIR=#{$build_dir} clean build"
end
