require 'rake/clean'

LIBNAME = "libIgor.a"
DIST = 'dist'
BUILD = 'build'

directory DIST
directory BUILD

VERSION = `agvtool vers -terse`.strip
BUILD_LIBNAME = "libIgor#{VERSION}.a"
DIST_LIBNAME = 'libIgor.a'

CLEAN.include BUILD, DIST

task :default => [:clean, :all, :dump]

desc "Build the universal library release version for distribution"
task :all => [:iphone, :simulator, DIST] do
    `lipo -create -output "#{DIST}/#{DIST_LIBNAME}" "#{BUILD}/Release-iphoneos/#{BUILD_LIBNAME}" "#{BUILD}/Release-iphonesimulator/#{BUILD_LIBNAME}"`
end

desc "Build the iPhone library release version"
task :iphone do
    build_for("iphoneos")
end

desc "Build the simulator library release version"
task :simulator do
    build_for("iphonesimulator")
end

desc "Dump the variables calculated by this Rakefile"
task :dump do
    puts 'Igor version  : ' + VERSION
    puts 'Built lib name: ' + BUILD_LIBNAME
    puts 'Dist lib name : ' + DIST_LIBNAME
end

def build_for(sdkname)
    sh "xcodebuild -sdk #{sdkname} -configuration Release BUILD_DIR=#{BUILD} clean build"
end
