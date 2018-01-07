#!/usr/bin/env ruby

require_relative 'config'

Gmail.connect(@email, @password) do |gmail|
  if gmail.logged_in?

    default_labels = [
        'INBOX',
        '[Gmail]',
        '[Gmail]/All Mail',
        '[Gmail]/Drafts',
        '[Gmail]/Important',
        '[Gmail]/Sent Mail',
        '[Gmail]/Spam',
        '[Gmail]/Starred',
        '[Gmail]/Trash',
        'Deleted Messages',
    ]

    labels = gmail.labels

    labels.each do |label|
        unless default_labels.include? label
          if gmail.labels.exists?(label)
            gmail.labels.delete(label)
          end
        end
    end

  else
    puts 'Not logged in'
  end

end