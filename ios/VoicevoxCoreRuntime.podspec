Pod::Spec.new do |spec|
  spec.name = 'VoicevoxCoreRuntime'
  spec.version = '0.16.4'
  spec.summary = 'Vendored VOICEVOX Core runtime for the app.'
  spec.homepage = 'https://github.com/VOICEVOX/voicevox_core'
  spec.license = { :type => 'MIT' }
  spec.author = { 'voivo_movie_maker' => 'local' }
  spec.source = { :path => '.' }
  spec.platform = :ios, '13.0'
  spec.vendored_frameworks = 'Frameworks/*.xcframework'
end
