class Embedded < ApplicationRecord
  has_one :media_source, as: :media
  has_one :track, through: :media_sources

  VALID_BANDCAMP_FORMAT = /^[https?:\/\/]+([a-z]+)\.bandcamp\.com\/track\/([^#\&\?\/]*)/i
  # https://ARTIST.bandcamp.com/track/TITLE

  VALID_SOUNDCLOUD_FORMAT = /^[https?:\/\/\soundcloud\.com]+\/([^#\&\?\/]*)\/([^#\&\?\/]*)/
  # https://soundcloud.com/ARTIST/TITLE

  VALID_SPOTIFY_FORMAT = /^(spotify:track:|https?:\/\/[a-z]+\.spotify\.com\/track\/)([^#\&\?\/]*)/i
  # spotify:track:2TpxZ7JUBn3uw46aR7qd6V
  # http://open.spotify.com/track/2TpxZ7JUBn3uw46aR7qd6V (or https)

  # Assign to service so API can be called
  def assign_api
    embedded_sources = {
      VALID_BANDCAMP_FORMAT => Bandcamp,
      VALID_SOUNDCLOUD_FORMAT => Soundcloud,
      VALID_SPOTIFY_FORMAT => Spotify
    }
    ADAPTER.assign_api(embedded_sources, source_path)
  end

end

class Bandcamp < Embedded

  # API parameters from input url
  def artist_path
    source_path.match.(VALID_BANDCAMP_FORMAT).captures[0]
    # regex conversion to lookup syntax
  end

  def title_path
    source_path.match.(VALID_BANDCAMP_FORMAT).captures[1]
    # regex conversion to lookup syntax
  end

  # API url structure with parameters
  def api_url
  end

end

class Soundcloud < Embedded

  # API parameters from input url
  def artist_path
    source_path.match.(VALID_SOUNDCLOUD_FORMAT).captures[0]
    # regex conversion to lookup syntax
  end

  def title_path
    source_path.match.(VALID_SOUNDCLOUD_FORMAT).captures[1]
    # regex conversion to lookup syntax
  end

  # API url structure with parameters
  def api_url
  end

end

class Spotify < Embedded

  # API parameters from input url
  def track_id
    source_path.match.(VALID_YT_FORMAT).captures[1]
    # (first match group is type (uri vs url), second is track id)
  end

  # API url structure with parameters
  def api_url
  end

end