require "digest"

architecture    = `uname -m`.strip

file_name       = "#{ENV['BUNDLE_ARCHIVE']}-#{architecture}.tgz"
file_path       = File.expand_path("~/#{file_name}")
lock_file       = File.join(File.expand_path(ENV["TRAVIS_BUILD_DIR"]), "Gemfile.lock")
digest_filename = "#{file_name}.sha2"
old_digest      = File.expand_path("~/remote_#{digest_filename}")

puts "Checking for changes"

bundle_digest = Digest::SHA2.file(lock_file).hexdigest.strip
old_digest    = File.exists?(old_digest) ? File.read(old_digest).strip : ""

if bundle_digest == old_digest
  puts "=> There were no changes, doing nothing"
else

  if old_digest == ""
    puts "=> There was no existing digest, uploading a new version of the archive"
  else
    puts "=> There were changes, uploading a new version of the archive"
    puts "  => Old checksum: [#{old_digest}] (Length: #{old_digest.length})"
    puts "  => New checksum: [#{bundle_digest}] (Length: #{bundle_digest.length})"
  end

  puts "Fetch expect"
  puts `sudo apt-get install expect`
  `which expect`
  puts "=> Preparing bundle archive"
  puts `cd ~ && tar -cjf #{file_name} .bundle`

  puts "=> Uploading the bundle"
  puts `/home/travis/build/boersmamarcel/challengesplatform/script/travis/send_files.sh ~/#{file_name}`

  puts "=> Uploading the digest file"
  `echo "#{bundle_digest}" > ~/#{digest_filename}`
  puts `/home/travis/build/boersmamarcel/challengesplatform/script/travis/send_files.sh ~/#{digest_filename}`

end

puts "All done now."
exit 0
