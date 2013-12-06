# Yep, a Ruby script that uses a Python script.
require 'pathname'
require 'fileutils'

pat = /.+(\d{4})\.nfm8/
Pathname.glob('fm8/*/').map do |game|
  print "Rename FM8 patches for #{game.basename}? "
  answer = gets.chomp

  next unless answer == "y"

  Pathname.glob("fm8/#{game.basename}/*/").map do |bgm|
    bgmdir = "#{bgm.dirname}/#{bgm.basename}"

    puts "\nDir name is #{bgm.basename}"
    print "What is the name of this BGM? "
    bgmname = gets.chomp

    Pathname.glob("#{bgmdir}/*0*.nfm8").map do |patch|
      matches = pat.match(patch.basename.to_s)
      patchnum = matches[1]

      newname = "#{bgmname} #{patchnum}.nfm8"
      puts "#{patch.basename} -> #{newname}"

      patch.rename("#{bgm.dirname}/#{newname}")
    end
  end
end
