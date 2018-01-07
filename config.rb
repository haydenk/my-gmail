require 'io/console'
require 'fileutils'
require 'gmail'
require 'progress_bar'

@email = nil
@password = nil

@backup_dir = File.join(File.dirname(__FILE__), 'backup')

if @email.nil?
  puts 'Email:'
  @email = STDIN.gets.chomp
end

if @password.nil?
  puts 'Password:'
  @password = STDIN.noecho(&:gets).chomp
end
