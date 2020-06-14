#!/usr/bin/env ruby
# frozen_string_literal: true

HELP_MSG = <<EOF
#{ File.basename __FILE__ } <audio file> <timestamps file> [<output directory>]

  <audio-file>       Audio file to be split
  <timestamps-file>  Timestamps file in format '00:00:13 Song one' per line
  <output directory> Output directory for files, defaults to $PWD
EOF

Song = Struct.new(:start_time, :name, :next_song) do
  def end_time
    return nil if not next_song
    next_song.start_time
  end

  def to_s
    "#{ start_time }-#{ end_time } #{ name }"
  end

  def each
    curr = self

    while curr.next_song do
      yield curr
      curr = curr.next_song
    end

    yield curr
  end
end

def show_help!
  abort HELP_MSG
end

def read_timestamps(filename)
  root = nil
  prev = nil
  values = []
  name = nil
  i = 1

  File.open(filename).each do |l|
    values = l.split(" ")
    name = sprintf("%02d - %s", i, values[1..-1].join(" "))
    song = Song.new(values.first, name)

    prev.next_song = song if prev
    prev = song
    root = song if not root
    i += 1
  end

  root
end

show_help! if ARGV.length < 2
audio = ARGV[0]
ext = File.extname(audio)
ts_file = ARGV[1]
output_dir = ARGV[2] || nil
output_dir = "#{ output_dir }/" if output_dir and not output_dir =~ /\/\Z/

songs = read_timestamps(ts_file)

songs.each do |s|
  outname = "#{ output_dir }#{ s.name }#{ ext }"
  cmd = "ffmpeg -i \"#{ audio }\" -acodec copy -ss #{ s.start_time }"
  cmd = "#{ cmd } -to #{ s.end_time }" if s.end_time
  cmd = "#{ cmd } \"#{ outname }\""

  # TODO?: execute command
  puts cmd
end
