# Print the user's city, region and country name
# in /WHOIS and /WHOWAS replies.
#
# /GEOIP <ip/host> prints the user's location for the host/ip
# /SET geoip_dat /full/path/to/GeoIP.dat
# /SET geoip_city_dat /full/path/to/GeoLiteCity.dat
#
# http://www.maxmind.com/download/geoip/database/GeoIP.dat.gz
# http://www.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz

use strict;
use Geo::IP;
use Irssi;
use Socket;
use locale;
use Encode 'decode';

use vars qw($VERSION %IRSSI);
$VERSION = "0.0.4";
%IRSSI = (
	authors         => "Toni Viemerö, Olaf Conradi",
	contact         => "toni.viemero\@iki.fi, olaf\@conradi.org",
	name            => "geoip",
	description     => "Print the user's city, region and country name" .
	                   "in /WHOIS and /WHOWAS replies",
	license         => "Public Domain",
	changed         => "Wed Apr 26 13:06:12 CET 2006"
);

sub query_geoip {
	my ($host) = lc shift;

	my $geoip_db = Irssi::settings_get_str("geoip_dat");
	my $geoip_city_db = Irssi::settings_get_str("geoip_city_dat");
	my $geoip;
	my $record;
	my $result = "";
	my $try = 2;

	# First try city database, it contains more detailed information
	if (-r $geoip_city_db) {
		$geoip = Geo::IP->open($geoip_city_db, GEOIP_STANDARD) || 0;
		if ($geoip) {
			$try--;
			if ($host =~ /^[0-9\.]*$/) {
				$record = $geoip->record_by_addr($host);
			} else {
				$record = $geoip->record_by_name($host);
			}
		}
		if ($record) {
			# Make sure each string is not a number
			if ($record->city =~ /^[^0-9]+$/) {
				$result = $record->city;
			}
			if ($record->region =~ /^[^0-9]+$/) {
				if ($result) {
					$result .= ", ";
				}
				$result .= $record->region;
			}
			if ($record->country_name =~ /^[^0-9]+$/) {
				if ($result) {
					$result .= ", ";
				}
				$result .= $record->country_name;
			}
		}
	}
	# Then try country database
	if ($result eq "") {
		if (-r $geoip_db) {
			$geoip = Geo::IP->open($geoip_db, GEOIP_STANDARD) || 0;
			if ($geoip) {
				$try--;
				if ($host =~ /^[0-9\.]*$/) {
					$result = $geoip->country_name_by_addr($host);
				} else {
					$result = $geoip->country_name_by_name($host);
				}
			}
		}
	}
	if ($try == 2) {
		Irssi::print("Script geoip: " .
		             "Could not open GeoIP databases '" .
		             $geoip_city_db . "' or '" .
		             $geoip_db . "'.");
	}
	# GeoIP databases are encoded in latin1
	return decode("latin1", $result);
}

sub event_whois {
	my ($server, $data) = @_;
	my ($me, $nick, $user, $host) = split(" ", $data);
	my $location = query_geoip($host);
	if ($location ne "") {
		$server->printformat($nick, MSGLEVEL_CRAP, 'whois_geoip', $host, $location);
	}
}

sub event_whowas {
	my ($server, $data) = @_;
	my ($me, $nick, $user, $host) = split(" ", $data);
	my $location = query_geoip($host);
	if ($location ne "") {
		$server->printformat($nick, MSGLEVEL_CRAP, 'whois_geoip', $host, $location);
	}
}

sub cmd_geoip {
	my $host = lc shift;
	if ($host eq "") {
		Irssi::print("USAGE: /GEOIP <host/ip>");
		return;
	}
	my $location = query_geoip($host);
	if ($location ne "") {
		Irssi::print("$host is in $location");
	} else {
		Irssi::print("Could not find host '$host' in GeoIP database");
	}
}

Irssi::theme_register([
	'whois_geoip'  => '{whois geoip %|$1}'
]);

Irssi::command_bind('geoip', \&cmd_geoip);
Irssi::signal_add_last('event 311', 'event_whois');
Irssi::signal_add_last('event 314', 'event_whowas');

Irssi::settings_add_str("misc", "geoip_dat",
	Irssi::get_irssi_dir() . "/GeoIP.dat");
Irssi::settings_add_str("misc", "geoip_city_dat",
	Irssi::get_irssi_dir() . "/GeoLiteCity.dat");

