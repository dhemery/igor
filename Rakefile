require 'rake/clean'

$version = '0.5.0'
$libname = "libIgor-#{$version}.a"

$dist_dir = 'dist'
$build_dir = 'build'

directory $dist_dir
directory $build_dir

CLEAN.include $build_dir, $dist_dir

desc "Build the universal library to dist, ready to release"
task :release => [:clean, :universal_library]
task :default => :release

desc "Build the iPhone library"
task :iphone_library do
    sh "xcodebuild -scheme igor -sdk iphoneos -configuration Release BUILD_DIR=#{$build_dir} clean build"
end

desc "Build the simulator library"
task :simulator_library do
    sh "xcodebuild -scheme igor -sdk iphonesimulator -configuration Release BUILD_DIR=#{$build_dir} clean build"
end

desc "Build the universal library"
task :universal_library => [:iphone_library, :simulator_library, $dist_dir] do
    `lipo -create -output "#{$dist_dir}/#{$libname}" "#{$build_dir}/Release-iphoneos/#{$libname}" "#{$build_dir}/Release-iphonesimulator/#{$libname}"`
end
