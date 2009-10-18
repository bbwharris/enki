google.load('search', '1.0');

function OnLoad() {
  var searchControl = new google.search.SearchControl();
  var webSearch = new google.search.WebSearch();
  webSearch.setSiteRestriction("brandon-harris.com");
  searchControl.addSearcher(webSearch);
  var imageSearch = new google.search.ImageSearch()
  imageSearch.setSiteRestriction("brandon-harris.com");
  searchControl.addSearcher(imageSearch);
  searchControl.draw(document.getElementById("searchcontrol"));
  searchControl.setResultSetSize(google.search.Search.SMALL_RESULTSET);
  searchControl.execute("");
}

google.setOnLoadCallback(OnLoad, true);
