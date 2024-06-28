class Endpoints {
  static const search = SearchEndpoints();
  static const songs = SongsEndpoints();
  static const albums = AlbumsEndpoints();
  static const artists = ArtistsEndpoints();
  static const playlists = PlaylistsEndpoints();

  static const String modules = 'content.getBrowseModules';
  static const String trending = 'content.getTrending';
}

class SearchEndpoints {
  const SearchEndpoints();

  final String all = 'autocomplete.get';
  final String top = 'content.getTopSearches';
  final String songs = 'search.getResults';
  final String albums = 'search.getAlbumResults';
  final String artists = 'search.getArtistResults';
  final String playlists = 'search.getPlaylistResults';
}

class SongsEndpoints {
  const SongsEndpoints();

  final String id = 'song.getDetails';
  final String link = 'webapi.get';
  final String suggestions = 'webradio.getSong';
  final String lyrics = 'lyrics.getLyrics';
  final String station = 'webradio.createEntityStation';
}

class AlbumsEndpoints {
  const AlbumsEndpoints();

  final String id = 'content.getAlbumDetails';
  final String link = 'webapi.get';
}

class ArtistsEndpoints {
  const ArtistsEndpoints();

  final String id = 'artist.getArtistPageDetails';
  final String link = 'webapi.get';
  final String songs = 'artist.getArtistMoreSong';
  final String albums = 'artist.getArtistMoreAlbum';
}

class PlaylistsEndpoints {
  const PlaylistsEndpoints();

  final String id = 'playlist.getDetails';
  final String link = 'webapi.get';
}
