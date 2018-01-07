#!/usr/bin/env ruby

require_relative 'config'

Gmail.connect(@email, @password) do |gmail|
  if gmail.logged_in?
    all_mail = gmail.mailbox(:all)
    bar = ProgressBar.new(all_mail.count)

    all_mail.emails.each do |e|

      unless e.nil?
        e.labels.each do |l|

          label_dir = File.join(backup_dir, l.to_s)

          unless File.exists?(label_dir)
            FileUtils::mkdir_p label_dir
          end

          message_subject = e.subject.gsub(/[^0-9a-z ]/i, '').gsub("/", "-")
          message_filename = "#{File.join(label_dir, message_subject[0..150])}-#{e.message_id}.txt"
          if File.exists? message_filename
            # e.delete!
          else
            File.open(message_filename, 'w') do |f|
              f.puts e.message
            end

            e.message.attachments.each do |a|
              attachment_filename = File.join(label_dir, a.filename)
              unless File.exists? attachment_filename
                File.open(attachment_filename, 'w') do |f|
                  f.puts a.body.decoded
                end
              end
            end

            if File.exists? message_filename and !e.nil?
              # e.delete!
            end
          end

        end
      end

      bar.increment!
    end
  else
    puts 'Not logged in'
  end

end