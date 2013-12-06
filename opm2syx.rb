# Yep, a Ruby script that uses a Python script.
require 'pathname'
require 'fileutils'

dxc_path = "../DXconvert-2.1.4/dxconvert.py"
in_games = []

Pathname.glob('opm/*/').map do |game|
  opmdir = "opm/#{game.basename}"
  syxdir = "syx/#{game.basename}"

  puts "Creating dir #{syxdir}"
  FileUtils.mkdir_p syxdir

  Pathname.glob("#{opmdir}/*").map do |opm|
    next unless opm.file?

    puts "\nConverting #{opm.basename}"
    opmname = "#{opmdir}/#{opm.basename}"
    syxname = "#{syxdir}/#{opm.basename.to_s.gsub(opm.extname, ".syx")}"

    puts "python #{dxc_path} \"#{opmname}\" \"#{syxname}\""
    puts `python #{dxc_path} "#{opmname}" "#{syxname}"`
  end
end
