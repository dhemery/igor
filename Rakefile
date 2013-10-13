require 'rake/clean'

LIBNAME = "libIgor.a"
DIST = 'dist'
BUILD = 'build'

directory DIST
directory BUILD

CLEAN.include BUILD, DIST

task :default => [:clean, :all, :dump]

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

desc "Dump the variables calculated by this Rakefile"
task :dump do
    puts 'Igor version: ' + `agvtool vers -terse`
    puts 'Lib name    : ' + LIBNAME

end

def build_for(sdkname)
    sh "xcodebuild -sdk #{sdkname} -configuration Release BUILD_DIR=#{BUILD} clean build"
end
