class Song < ActiveRecord::Base
  attr_accessible :user_id, :song, :youtube_key, :rating, :name, :artist

  belongs_to :user
  has_and_belongs_to_many :playlists

  has_attached_file :song, path: ':rails_root/public/:class/song/:filename', url: '/songs/song/:filename'

  before_save :download_if_necessary

  validates :name, presence: true
  validates_attachment :song, content_type: { content_type: ['audio/mp3', 'audio/mp4', 'audio/ogg', 'audio/x-aiff'] }
  validates_format_of :youtube_key, with: /\A[A-Za-z0-9\-_]*\Z/

  validate { !song.blank? || !youtube_key.blank? }

  def cache_from_youtube!
    `youtube-dl #{youtube_key} -o "tmp/#{youtube_key}.video"`
    begin
      if File.exists?("tmp/#{youtube_key}.video")
        `cd tmp && any2mp3.sh #{youtube_key}.video`
        self.song = File.open("tmp/#{youtube_key}.mp3")
        save
        File.delete("tmp/#{youtube_key}.mp3")
      else
        self.errors.add :song, 'could not be downloaded.'
      end
    ensure
      File.delete("tmp/#{youtube_key}.video")
    end
  end

  def download_if_necessary
    if self.youtube_key && self.song.blank?
      self.cache_from_youtube!
    end
  end
end
