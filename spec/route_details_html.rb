require 'erb'

module SendspotScraper
  class RouteDetailsValues
    attr_accessor :setter_name, :setter_nick, :has_setter_nick, :has_setter_link,
                  :gym, :location, :has_location,
                  :name, :grade,
                  :types, :has_climb_types_element

    def initialize(values = {})
      defaults = {
        :has_setter_link => true,
        :has_setter_nick => true,
        :setter_name => 'Ryan Blah',
        :setter_nick => 'Ryan B',

        :gym => 'Earth Treks',
        :location => 'Rockville',
        :has_location => true,

        :name => 'Pity The Fool',
        :grade => '5.10b',

        :has_climb_types_element => true,
        :types => ['Lead', 'Top-Rope']
      }
      values = defaults.merge(values)

      values.each do |k, v|
        self.__send__("#{k}=", v)
      end
    end

    def the_binding
      binding
    end

    def setter
      str = "#{setter_name} "
      str << "(#{setter_nick})" if has_setter_nick
      str
    end

    def setter_link
      has_setter_link ? "<a href=\"setter?sid=18\">#{setter}</a>" : ""
    end

    def climb_types
      types.join(' / ')
    end

    def climb_types_element
      has_climb_types_element ? "<p><strong>Type:</strong> #{climb_types}</p>" : ""
    end

    def location_in_parens
      "(#{location})" if has_location
    end
  end

  def self.route_details_html(values = {})
    params = RouteDetailsValues.new(values)
    ERB.new(ROUTE_DETAILS_HTML).result(params.the_binding)
  end

  # Taken from https://secure.thesendspot.com/earthtreks/route?rid=3302
  # on 2013-03-07
  ROUTE_DETAILS_HTML =<<HTML
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta property="og:title" content="<%= name %> (<%= grade %>)" />
             <meta property="og:description" content="Set by Ryan Blah at <%= gym %> <%= location_in_parens %> from theSendSpot.com" />
             <meta property="og:type" content="website" />
             <meta property="og:url" content="https://secure.thesendspot.com/earthtreks/route.php?rid=3302" />
             <meta property="og:image" content="http://thesendspot.com/vc/images/theSendSpot_ogimage.png" />
             <meta property="og:site_name" content="The Send Spot" />
             <meta property="fb:admins" content="100004070853444" /><title>The Send Spot  - <%= name %> (<%= grade %>) at <%= gym %> <%= location_in_parens %></title>
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
<body align="center" onload="initData()">
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
<script type="text/javascript" src="topup/javascripts/top_up-min.js"></script>
<script type="text/javascript">
  TopUp.images_path = "/vc/topup/images/top_up/";
</script>
<SCRIPT LANGUAGE="JavaScript" SRC="calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<script src="./flowplayer/flowplayer-3.2.11.min.js"></script>
<DIV ID="calendarDiv" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>
<STYLE> .TESTcpYearNavigation, .TESTcpMonthNavigation { background-color:#6677DD; text-align:center; vertical-align:center; text-decoration:none; color:#FFFFFF; font-weight:bold; } .TESTcpDayColumnHeader, .TESTcpYearNavigation, .TESTcpMonthNavigation, .TESTcpCurrentMonthDate, .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDate, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDate, .TESTcpCurrentDateDisabled, .TESTcpTodayText, .TESTcpTodayTextDisabled, .TESTcpText { font-family:arial; font-size:8pt; } TD.TESTcpDayColumnHeader { text-align:right; border:solid thin #6677DD; border-width:0 0 1 0; } .TESTcpCurrentMonthDate, .TESTcpOtherMonthDate, .TESTcpCurrentDate { text-align:right; text-decoration:none; } .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDateDisabled { color:#D0D0D0; text-align:right; text-decoration:line-through; } .TESTcpCurrentMonthDate { color:#6677DD; font-weight:bold; } .TESTcpCurrentDate { color: #FFFFFF; font-weight:bold; } .TESTcpOtherMonthDate { color:#808080; } TD.TESTcpCurrentDate { color:#FFFFFF; background-color: #6677DD; border-width:1; border:solid thin #000000; } TD.TESTcpCurrentDateDisabled { border-width:1; border:solid thin #FFAAAA; } TD.TESTcpTodayText, TD.TESTcpTodayTextDisabled { border:solid thin #6677DD; border-w<STYLE> .TESTcpYearNavigation, .TESTcpMonthNavigation { background-color:#6677DD; text-align:center; vertical-align:center; text-decoration:none; color:#FFFFFF; font-weight:bold; } .TESTcpDayColumnHeader, .TESTcpYearNavigation, .TESTcpMonthNavigation, .TESTcpCurrentMonthDate, .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDate, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDate, .TESTcpCurrentDateDisabled, .TESTcpTodayText, .TESTcpTodayTextDisabled, .TESTcpText { font-family:arial; font-size:8pt; } TD.TESTcpDayColumnHeader { text-align:right; border:solid thin #6677DD; border-width:0 0 1 0; } .TESTcpCurrentMonthDate, .TESTcpOtherMonthDate, .TESTcpCurrentDate { text-align:right; text-decoration:none; } .TESTcpCurrentMonthDateDisabled, .TESTcpOtherMonthDateDisabled, .TESTcpCurrentDateDisabled { color:#D0D0D0; text-align:right; text-decoration:line-through; } .TESTcpCurrentMonthDate { color:#6677DD; font-weight:bold; } .TESTcpCurrentDate { color: #FFFFFF; font-weight:bold; } .TESTcpOtherMonthDate { color:#808080; } TD.TESTcpCurrentDate { color:#FFFFFF; background-color: #6677DD; border-width:1; border:solid thin #000000; } TD.TESTcpCurrentDateDisabled { border-width:1; border:solid thin #FFAAAA; } TD.TESTcpTodayText, TD.TESTcpTodayTextDisabled { border:solid thin #6677DD; border-width:1 0 0 0; } A.TESTcpTodayText, SPAN.TESTcpTodayTextDisabled { height:20px; } A.TESTcpTodayText { color:#6677DD; font-weight:bold; } SPAN.TESTcpTodayTextDisabled { color:#D0D0D0; } .TESTcpBorder { border:solid thin #6677DD; } </STYLE>
        <p>
        <strong>
                <img src="./images/tape_orange.png" border="0">        <%= name %>         -
        <%= grade %>
        </strong>
         - set by
        <strong>
        <%= setter_link %>
        </strong>
        </p>
        <p>
        at
        <a href="gym?gid=3"><%= gym %> <%= location_in_parens %></a>
        </p>
        <p>
        <span id="routeRating"></span>
        <span id="averageUserGrade"></span>
        <small>Set on 2013-03-07</small>

    <!-- <table height="8"><tr><td></td></tr></table>
    <iframe src="//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fsecure.thesendspot.com%2Fvc%2Froute?rid=3302&amp;send=false&amp;layout=standard&amp;width=450&amp;show_faces=false&amp;action=recommend&amp;colorscheme=light&amp;font&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:35px;" allowTransparency="true"></iframe> -->
    <div class="fb-like" data-href="https://secure.thesendspot.com/vc/route?rid=3302" data-send="false" data-width="450" data-show-faces="false" data-action="recommend" data-font="trebuchet ms"></div>
    <span id="numberOfSends"></span>
        </small>
        </p>
        <div class="main">
        <p>
            <table width="280">
            <tr><td align="right"><a href="./route?rid=3302&full"><small>Show Full-Size</small></a></td></tr>
            <tr><td>
      <div class="white_image" style="position: relative; left: 0px; top: 0px;">
        <img src="./user_images/3f03818a22db27c3eb99c81886ea12c8_rockville_large.png" width="280" height="314.61818181818">
        <img src="images/marker.png" style="position: absolute; top: 125.23636363636px; left: 270.32727272727px;" alt="<%= name %>">
      </div>
            </td></tr></table>
        </p>
    <small>
    <%= climb_types_element %>
    <p><strong>Color:</strong> Orange</p>
        <p><strong>Description:</strong> </p>
    </small>
        </div>
<script language="JavaScript">
function point_it(event, newFactor){
  pos_x = event.offsetX?(event.offsetX):event.pageX-document.getElementById("pointer_div").offsetParent.offsetLeft;
  pos_y = event.offsetY?(event.offsetY):event.pageY-document.getElementById("pointer_div").offsetParent.offsetTop;
  document.getElementById("marker").style.left = (pos_x) +'px';
  document.getElementById("marker").style.top = (pos_y) +'px';
  document.getElementById("marker").style.visibility = "visible";
  document.update.floorplan_x.value = pos_x;
  document.update.floorplan_y.value = pos_y;
  document.route.floorplan_x.value = pos_x * newfactor;
  document.route.floorplan_y.value = pos_y * newfactor;
}
</script>

    <p><strong>Send and Attempt Statistics</strong></p>
  <span id="sendAndAttemptStatistics"></span>
    <p><strong>Sends</strong></p>
    <span id="sendHistory"></span>
    <p><strong>Attempts</strong></p>
    <span id="attemptHistory"></span>

<script type="text/javascript">
function initData()
{
getAndDisplayData('./routea?rid=3302&averageUserGrade','averageUserGrade');
getAndDisplayData('./routea?rid=3302&routeRating','routeRating');
getAndDisplayData('./routea?rid=3302&statistics','sendAndAttemptStatistics');
getAndDisplayData('./routea?rid=3302&numberOfSends','numberOfSends');
getAndDisplayData('./routea?rid=3302&sends','sendHistory');
getAndDisplayData('./routea?rid=3302&attempts','attemptHistory');
getAndDisplayData('./routea?rid=3302&myRecordedRating','myRecordedRating');
getAndDisplayData('./routea?rid=3302&myRecordedGrade','myRecordedGrade');
}
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