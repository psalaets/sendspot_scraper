require 'erb'

module SendspotScraper
  class SearchResultsValues
    attr_accessor :result_type

    # result_type can be :some, :empty, :invalid
    # :invalid means the markup has changed somehow and it's not extractable.
    def initialize(result_type = :some)
      @result_type = result_type
    end

    def search_results
      case @result_type
      when :some
        wrap_search_results(some_results)
      when :empty
        wrap_search_results(empty_results)
      else
        # This simulates "invalid" results - show nothing, not even wrapper.
        ""
      end
    end

    # Wrap a String in the form that always wraps search results.
    def wrap_search_results(results)
      wrapper =<<WRAPPER
<form name="sendMode">
  #{results}
</form>
WRAPPER
    end

    def some_results
      results =<<RESULTS
                    <div class="main_header">
              <strong>
                        <a href="./gym?gid=3">
                        <img src="./images/gym.png" border="0">
                        Earth Treks                        (Rockville)
                        </a>
                        </strong>
                        <br/>
                        <small><a href="./routes?gid=3">(All Routes at this gym...)</a></small>
          </div>
                    <p>
          <table cellpadding="0" valign="center">

                    <tr align="center" valign="middle">
                        <td valign="middle">
                        <img src="./images/new-text.png"><a href="./route?rid=3302">
                        <img src="./images/tape_orange.png" border="0">                                                <strong>
            Pity The Fool           </strong>
                                                -
                        5.10b
                        </a>
                        <small>set by </small>
                        <a href="./setter?sid=18">
                        <img src="./images/user-gray.png" border="0">
              Ryan Blah                        </a>
          </td>
                    </tr>
          <tr bgcolor="#bbd5f6" height="1"><td colspan="4"></td></tr>
                    <tr align="center" valign="middle">
                        <td valign="middle">
                        <img src="./images/new-text.png"><a href="./route?rid=3260">
                        <img src="./images/tape_black.png" border="0">                                                <strong>
            Mojo            </strong>
                                                -
                        V5
                        </a>
                        <small>set by </small>
                        <a href="./setter?sid=5">
                        <img src="./images/user-gray.png" border="0">
              Skilla                        </a>
          </td>
                    </tr>
          <tr bgcolor="#bbd5f6" height="1"><td colspan="4"></td></tr>
        </table>
        </p>
RESULTS
    end

    def empty_results
      %q{        <p><strong><font color="red">Whoa, we couldn't find any routes that matched your search!</font></strong></p>}
    end

    def the_binding
      binding
    end
  end

  # type = :some, :empty or :invalid
  def self.search_results_html(type = :some)
    values = SearchResultsValues.new(type)
    ERB.new(SEARCH_RESULTS_HTML).result(values.the_binding)
  end

  SEARCH_RESULTS_HTML =<<HTML
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta property="og:title" content="The Send Spot" />
<meta property="og:type" content="website" />
<meta property="og:url" content="http://thesendspot.com" />
<meta property="og:image" content="http://thesendspot.com/vc/images/theSendSpot_ogimage.png" />
<meta property="og:site_name" content="The Send Spot" />
<meta property="fb:admins" content="507909082" />
<title>The Send Spot </title>
<link rel="stylesheet" href="style.css">
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-35374497-1']);
  _gaq.push(['_setDomainName', 'thesendspot.com']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
</head>
<body align="center" >
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<script type="text/javascript">
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>
<script src="scripts.js" type="text/javascript"></script>
<center>
<noscript>
<div class="warning_bar">
<strong>Javascript is disabled on this browser. Please enable javascript to use this site.</strong>
</div>
</noscript>
    <div class="header">
    <!-- <a href="./index"> -->
    <img src="./images/theSendSpot_logo_white_small.png" border="0">
    <!-- </a> -->
    </div>
    <table width="100%" height="3" cellspacing="0" cellpadding="0" bgcolor="#727272"><tr><td></td></tr></table>
<div class="header_bar">
<table height="2" cellspacing="0" cellpadding="0"><tr><td></td></tr></table>
<a href="signup">sign up</a> |
<a href="login">log-in</a> |
<a href="home">home</a> |
<a href="gyms">gyms</a> |
<a href="routes">routes</a> |
<a href="setters">setters</a> |
<a href="leagues">ranks</a> |
<a href="trainings">training</a>
| <a href="contact">about</a>
<table height="2" cellspacing="0" cellpadding="0"><tr><td></td></tr></table>
</div>
<!--
<table align="center" width="100%" cellspacing="0" cellpadding="0">
<tr><td align="center">
<div class="marquee">
<table>
<tr>
  <td><img src="./images/hand.png"/></td>
  <td><img src="./images/theSendSpot_logo_white_small.png"></td>
</tr>
</table>

</div>
</td></tr></table>
-->

<table height="10"><tr><td></td></tr></table>
<table align="center">
<tr align="center" id="body"><td>
<SCRIPT LANGUAGE="JavaScript" SRC="calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<DIV ID="calendarDiv" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>
<STYLE> .TESTcpYearNavigation, .TESTcpMonthNavigation { background-color:#6677DD; text-align:center; vertical-align:center; text-decoration:none; color:#FFFFFF; font-weight:bold; } .TESTcpDayColumnHeader, .TESTcpYearNavigation, .TESTcpMonthNavigation, .TESTcpCurrentMonthDate, .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDate, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDate, .TESTcpCurrentDateDisabled, .TESTcpTodayText, .TESTcpTodayTextDisabled, .TESTcpText { font-family:arial; font-size:8pt; } TD.TESTcpDayColumnHeader { text-align:right; border:solid thin #6677DD; border-width:0 0 1 0; } .TESTcpCurrentMonthDate, .TESTcpOtherMonthDate, .TESTcpCurrentDate { text-align:right; text-decoration:none; } .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDateDisabled { color:#D0D0D0; text-align:right; text-decoration:line-through; } .TESTcpCurrentMonthDate { color:#6677DD; font-weight:bold; } .TESTcpCurrentDate { color: #FFFFFF; font-weight:bold; } .TESTcpOtherMonthDate { color:#808080; } TD.TESTcpCurrentDate { color:#FFFFFF; background-color: #6677DD; border-width:1; border:solid thin #000000; } TD.TESTcpCurrentDateDisabled { border-width:1; border:solid thin #FFAAAA; } TD.TESTcpTodayText, TD.TESTcpTodayTextDisabled { border:solid thin #6677DD; border-w<STYLE> .TESTcpYearNavigation, .TESTcpMonthNavigation { background-color:#6677DD; text-align:center; vertical-align:center; text-decoration:none; color:#FFFFFF; font-weight:bold; } .TESTcpDayColumnHeader, .TESTcpYearNavigation, .TESTcpMonthNavigation, .TESTcpCurrentMonthDate, .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDate, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDate, .TESTcpCurrentDateDisabled, .TESTcpTodayText, .TESTcpTodayTextDisabled, .TESTcpText { font-family:arial; font-size:8pt; } TD.TESTcpDayColumnHeader { text-align:right; border:solid thin #6677DD; border-width:0 0 1 0; } .TESTcpCurrentMonthDate, .TESTcpOtherMonthDate, .TESTcpCurrentDate { text-align:right; text-decoration:none; } .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDateDisabled { color:#D0D0D0; text-align:right; text-decoration:line-through; } .TESTcpCurrentMonthDate { color:#6677DD; font-weight:bold; } .TESTcpCurrentDate { color: #FFFFFF; font-weight:bold; } .TESTcpOtherMonthDate { color:#808080; } TD.TESTcpCurrentDate { color:#FFFFFF; background-color: #6677DD; border-width:1; border:solid thin #000000; } TD.TESTcpCurrentDateDisabled { border-width:1; border:solid thin #FFAAAA; } TD.TESTcpTodayText, TD.TESTcpTodayTextDisabled { border:solid thin #6677DD; border-width:1 0 0 0; } A.TESTcpTodayText, SPAN.TESTcpTodayTextDisabled { height:20px; } A.TESTcpTodayText { color:#6677DD; font-weight:bold; } SPAN.TESTcpTodayTextDisabled { color:#D0D0D0; } .TESTcpBorder { border:solid thin #6677DD; } </STYLE>
<img src="./images/routes.png">
<table valign="center">
<tr>
    <td>
        <img src="./images/search_icon.png" border="0"></td>
    <td>
        <span id="search_criteria_show" style="display: block">
            <font color="red"><strong><a href="javascript:toggleDisplayArea('search_criteria','search_criteria_show','search_criteria_hide');">Search For A Route...</a></strong></font>
        </span>
        <span id="search_criteria_hide" style="display: none">
            <strong><a href="javascript:toggleDisplayArea('search_criteria','search_criteria_show','search_criteria_hide');">Hide Search Criteria</a></strong>
        </span>
    </td>
</tr>
</table>
<div id="search_criteria" style="display: none"><p>
<div class="configure">
<script src="jcrop/js/jquery.min.js" type="text/javascript"></script>
<script src="jcrop/js/jquery.Jcrop.js" type="text/javascript"></script>
<link rel="stylesheet" href="jcrop/css/jquery.Jcrop.css" type="text/css" />
<script type="text/javascript">
  function clearAllFloorplans()
  {
document.getElementById('floorplansearch1').style.display='none';document.getElementById('floorplansearch2').style.display='none';document.getElementById('floorplansearch3').style.display='none'; }

  function hideOrShowMainSearch()
  {
    if(document.searchByLocation.floorplanimage.value == 0)
    {
      document.getElementById('mainSearch').style.display='block';
    }
    else
    {
      document.getElementById('mainSearch').style.display='none';
    }
  }
</script>
<form name="searchByLocation" action="./routes?searchByLocation" method="GET">
<div class="message">
<img src="./images/search_icon.png" border="0" height="15" width="15">
<small><strong>Search for routes <font color="red">by location</font> at a gym:</strong></small>
<select name="floorplanimage" onChange="javascript:clearAllFloorplans(); hideOrShowMainSearch(); document.getElementById('floorplansearch'+document.searchByLocation.floorplanimage.value).style.display='block'; document.searchByLocation.gid.value = document.searchByLocation.floorplanimage.value;">
<option value="0">Select a Gym</option>
<option value="1">Earth Treks(Columbia)</option><option value="2">Earth Treks(Timonium)</option><option value="3">Earth Treks(Rockville)</option></select><br/>
<span style="display: none" id="floorplansearch1"><br/><small>Select an area with the mouse by clicking and dragging</small><br/><br/><img id="floorplantarget1" src="./user_images/3536393e8dbf3d99613e7a23fb56680b_columbia2.png" width="586" height="1053"><br/><a href="#" onclick="javascript:document.searchByLocation.submit();"><img src="./images/btn_search.png" border="0"></a></span><span style="display: none" id="floorplansearch2"><br/><small>Select an area with the mouse by clicking and dragging</small><br/><br/><img id="floorplantarget2" src="./user_images/371a5840a5b27f2f4a4f33ad59e417bf_timonium2.png" width="550" height="379"><br/><a href="#" onclick="javascript:document.searchByLocation.submit();"><img src="./images/btn_search.png" border="0"></a></span><span style="display: none" id="floorplansearch3"><br/><small>Select an area with the mouse by clicking and dragging</small><br/><br/><img id="floorplantarget3" src="./user_images/3f03818a22db27c3eb99c81886ea12c8_rockville_large.png" width="550" height="618"><br/><a href="#" onclick="javascript:document.searchByLocation.submit();"><img src="./images/btn_search.png" border="0"></a></span><input type="hidden" name="floorplan_x1" value="0">
<input type="hidden" name="floorplan_y1" value="0">
<input type="hidden" name="floorplan_x2" value="0">
<input type="hidden" name="floorplan_y2" value="0">
<input type="hidden" name="gid" value="0">
</div>
</form>

<div id="mainSearch">
<form name="search" action="routes?" method="GET">
<input type="hidden" name="searching" value="1">

<p>
<small>Search for a route with the following criteria. Leave any of the fields blank to specify ANY for that particular category. When you search
for routes, your max grade and route type preferences are ignored. Gym preferences (only look at these gyms) is always used.</small></p>
<table valign="center">
<tr>
    <td>Name / Description / Color:</td>
    <td align="left"><input type="text" name="string" onkeypress="javascript:if(event.keyCode==13) document.search.submit();"></td>
</tr>
<tr>
    <td>By Route Type:</td>
    <td align="left">
    <input type="checkbox" name="rt_lead" CHECKED> Lead <br/>
    <input type="checkbox" name="rt_toprope" CHECKED> Top Rope <br/>
    <input type="checkbox" name="rt_boulder" CHECKED> Boulder <br/>
    </td>
</tr>
<tr>
    <td>By Route Grade:</td>
    <td align="left">
    <select name="start_grade">
    <option value="0">Any</option>
<option value="1">5.1</option><option value="2">5.2</option><option value="3">5.3</option><option value="4">5.4</option><option value="5">5.5</option><option value="6">5.6</option><option value="7">5.7</option><option value="8">5.8</option><option value="9">5.9</option><option value="10">5.10a</option><option value="11">5.10b</option><option value="12">5.10c</option><option value="13">5.10d</option><option value="14">5.11a</option><option value="15">5.11b</option><option value="16">5.11c</option><option value="17">5.11d</option><option value="18">5.12a</option><option value="19">5.12b</option><option value="20">5.12c</option><option value="21">5.12d</option><option value="22">5.13a</option><option value="23">5.13b</option><option value="24">5.13c</option><option value="25">5.13d</option><option value="26">5.14a</option><option value="27">5.14b</option><option value="28">5.14c</option><option value="29">5.14d+</option><option value="30">V Intro</option><option value="31">V0</option><option value="32">V1</option><option value="33">V2</option><option value="34">V3</option><option value="35">V4</option><option value="36">V5</option><option value="37">V6</option><option value="38">V7</option><option value="39">V8</option><option value="40">V9</option><option value="41">V10</option><option value="42">V11</option><option value="43">V12</option><option value="44">V13</option><option value="45">V14</option><option value="46">V15</option>    </select>
    to
    <select name="end_grade">
    <option value="0">Any</option>
<option value="1">5.1</option><option value="2">5.2</option><option value="3">5.3</option><option value="4">5.4</option><option value="5">5.5</option><option value="6">5.6</option><option value="7">5.7</option><option value="8">5.8</option><option value="9">5.9</option><option value="10">5.10a</option><option value="11">5.10b</option><option value="12">5.10c</option><option value="13">5.10d</option><option value="14">5.11a</option><option value="15">5.11b</option><option value="16">5.11c</option><option value="17">5.11d</option><option value="18">5.12a</option><option value="19">5.12b</option><option value="20">5.12c</option><option value="21">5.12d</option><option value="22">5.13a</option><option value="23">5.13b</option><option value="24">5.13c</option><option value="25">5.13d</option><option value="26">5.14a</option><option value="27">5.14b</option><option value="28">5.14c</option><option value="29">5.14d+</option><option value="30">V Intro</option><option value="31">V0</option><option value="32">V1</option><option value="33">V2</option><option value="34">V3</option><option value="35">V4</option><option value="36">V5</option><option value="37">V6</option><option value="38">V7</option><option value="39">V8</option><option value="40">V9</option><option value="41">V10</option><option value="42">V11</option><option value="43">V12</option><option value="44">V13</option><option value="45">V14</option><option value="46">V15</option>    </select>
    </td>
</tr>
<tr>
    <td>By Gym:</td>
    <td align="left">
    <select name="gym">
    <option value="0">Any</option>
<option value="1">Earth Treks (Columbia)</option><option value="2">Earth Treks (Timonium)</option><option value="3">Earth Treks (Rockville)</option>    </select>
    </td>
</tr>
<tr>
    <td>By Setter:</td>
    <td align="left">
    <select name="setter">
    <option value="0">Any</option>
<option value="6">Will Anglin (Will)</option><option value="2">Ryan Banister (RB)</option><option value="3">Matt Bosley (OMB)</option><option value="5">Ward Byrum (Skilla)</option><option value="1">Keith Dickey (Dickey)</option><option value="14">Joel Gilmore (JG)</option><option value="4">Brian  Hughes (BH)</option><option value="8">Matt  Jones (MJ)</option><option value="18">Ryan Jones ()</option><option value="11">Jeff Mascaro (Jeff)</option><option value="19">Harris Pfau (Harris)</option><option value="10">Dean Privett (DNO)</option><option value="17">Mike Ray (Mikey)</option><option value="15">Tim Rose (T Rose)</option><option value="16">Guest Setter (Guest)</option><option value="12">Griffin Whiteside (Griffin)</option><option value="7">Ellis Whitson (Wizard)</option>    </select>
    </td>
</tr>
<tr>
    <td>By Set-On Date:</td>
    <td align="left">
    <input type="text" name="start_date" size="12">
    <SCRIPT LANGUAGE="JavaScript" ID="jscal"> var cal = new CalendarPopup("calendarDiv"); cal.showNavigationDropdowns(); </SCRIPT>
    <A HREF="#" onClick="cal.select(document.search.start_date,'calAnchor1','yyyy-MM-dd'); return false;" TITLE="cal.select(document.search.start_date,'calAnchor1','yyyy-MM-dd'); return false;" NAME="calAnchor1" ID="calAnchor1"><img src="./images/calendar.png" border="0"></A>
    <small><small>(YYYY-MM-DD)</small></small>
    <br/>to<br/>
    <input type="text" name="end_date" size="12">
    <SCRIPT LANGUAGE="JavaScript" ID="jscal"> var cal = new CalendarPopup("calendarDiv"); cal.showNavigationDropdowns(); </SCRIPT>
    <A HREF="#" onClick="cal.select(document.search.end_date,'calAnchor2','yyyy-MM-dd'); return false;" TITLE="cal.select(document.search.end_date,'calAnchor2','yyyy-MM-dd'); return false;" NAME="calAnchor2" ID="calAnchor2"><img src="./images/calendar.png" border="0"></A>
    <small><small>(YYYY-MM-DD)</small></small>
    </td>
</tr>
<tr>
    <td></td>
    <td align="left"><small><input type="checkbox" name="includeDownRoutes"> include routes that have been taken down</small></td>
</tr>
<tr>
    <td></td>
    <td align="left"><small><input type="checkbox" name="includeHistoricalRoutes"> include historical routes (over 1 year old)</small></td>
</tr>
<tr><td height="10" colspan="2"></td></tr>
<tr>
    <td>Sort By:</td>
    <td align="left">
    <select name="sort_by">
    <option value=""></option>
  <option value="grade">Grade</option>
  <option value="rating">Rating</option>
  <option value="dateup">Date Up</option>
  <option value="setter">Setter</option>
    </select>
    </td>
</tr>
<tr>
    <td>Sort Order:</td>
    <td align="left">
  <select name="sort_order">
    <option value=""></option>
  <option value="descending">Descending</option>
  <option value="ascending">Ascending</option>
  </select>
    </td>
</tr>
<tr><td height="10" colspan="2"></td></tr>
<tr>
    <td></td>
    <td align="left"><a href="#" onclick="javascript:document.search.submit();"><img src="./images/btn_search.png" border="0"></a></td>
</tr>
</table>
</form>
</div>
</div>
</p>
</div>

<div class="main">
<%= search_results %>
</div>
<p>
<small>
Routes are listed in order from newest to oldest, and grouped by gyms in alphabetical order by name.
<br/><br/>
To Search for a particular route click on the <strong>Search For A Route</strong> link at the top of the page to expand
the search criteria pane. There you can search by name, color, description, grade, type, gym, setter, and dates.
</small>
</p>

<script type="text/javascript">
    function showCoords1(c)
    {
      document.searchByLocation.floorplan_x1.value = c.x * 1;
      document.searchByLocation.floorplan_y1.value = c.y * 1;
      document.searchByLocation.floorplan_x2.value = c.x2 * 1;
      document.searchByLocation.floorplan_y2.value = c.y2 * 1;
    };
    function showCoords2(c)
    {
      document.searchByLocation.floorplan_x1.value = c.x * 1;
      document.searchByLocation.floorplan_y1.value = c.y * 1;
      document.searchByLocation.floorplan_x2.value = c.x2 * 1;
      document.searchByLocation.floorplan_y2.value = c.y2 * 1;
    };
    function showCoords3(c)
    {
      document.searchByLocation.floorplan_x1.value = c.x * 1;
      document.searchByLocation.floorplan_y1.value = c.y * 1;
      document.searchByLocation.floorplan_x2.value = c.x2 * 1;
      document.searchByLocation.floorplan_y2.value = c.y2 * 1;
    };

$(window).load(function(){

  var jcrop_api;
  var i, ac;

  initJcrop();

  function initJcrop()
  {

    jcrop_api = $.Jcrop('#floorplantarget1');

    jcrop_api.setOptions({
      onChange:   showCoords1,
      onSelect:   showCoords1,
setSelect: [ 20, 20, 100, 100 ]     //trueSize: [586,1053]
    });
    jcrop_api = $.Jcrop('#floorplantarget2');

    jcrop_api.setOptions({
      onChange:   showCoords2,
      onSelect:   showCoords2,
setSelect: [ 20, 20, 100, 100 ]     //trueSize: [586,1053]
    });
    jcrop_api = $.Jcrop('#floorplantarget3');

    jcrop_api.setOptions({
      onChange:   showCoords3,
      onSelect:   showCoords3,
setSelect: [ 20, 20, 100, 100 ]     //trueSize: [586,1053]
    });
  };

  function nothing(e)
  {
    e.stopPropagation();
    e.preventDefault();
    return false;
  };
});


</script>

    <p>
    <p><div class="fb-like" data-href="https://secure.thesendspot.com/vc/" data-send="true" data-show-faces="false" data-width="450" data-show-faces="true"></div></p>
    <!-- <iframe src="//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fsecure.thesendspot.com%2Fvc%2F&amp;send=false&amp;layout=standard&amp;width=450&amp;show_faces=true&amp;action=like&amp;colorscheme=light&amp;font&amp;height=80" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:80px;" allowTransparency="true"></iframe> -->
    <br/>
    <div><g:plusone></g:plusone></div>
    </p>
<div class="footer" align="center">
<a href="signup">sign up</a> |
<a href="login">log-in</a> |
<a href="home">home</a> |
<a href="gyms">gyms</a> |
<a href="routes">routes</a> |
<a href="setters">setters</a> |
<a href="leagues">ranks</a> |
<a href="trainings">training</a> |
<a href="contact">about</a>
<table height="10"><tr><td></td></tr></table>
    <small><a href="./mlogin">Manager Login</a></small><br/><br/>
<small>Copyright 2012, <strong>theSendSpot.com</strong> - <a href="mailto:support@thesendspot.com">support@theSendSpot.com</a></small>
<br/><br/>
<small>(This site is best viewed in <strong><a href="http://www.google.com/chrome">Google Chrome</a></strong>, <strong><a href="http://www.apple.com/safari/">Apple Safari</a></strong>, or <strong><a href="http://www.mozilla.org/en-US/firefox/new/">Mozilla FireFox</a></strong>)</small>
<br/><br/>
</div>
</td></tr>
</table>
</center>
</body>
</html>
HTML
end